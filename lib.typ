
#let contacts = (
  (content: [johndoe], link: "https://github.com/johndoe", icon: "icons/github-mark.svg"), 

  (content: [#"johndoe@johndoemail.com"], icon: "icons/email-svgrepo-com.svg", link: "mailto:johndoe@johndoemail.com")
)

#let cv_template(firstName: "John", surname: "Doe", contacts: contacts, photo: "icons/blank-image.svg", logo: none, body) = {
  set text(font: "Linux Libertine")
  // header
  let headerFont = "Roboto"
  let first-name-header-section = [    
        #set text(
          font: headerFont,
          size: 32pt,
          weight: "light",
          fill: rgb("#212529")
        )
        #firstName
      ]

  let surname-header-section = [
        #set text(
            font: headerFont,
            size: 32pt,
            weight: "bold",
            fill: rgb("#212529")
        )
        #surname
      ]
  let create-header = [
    #let create-contact-info = [
        #let addIcon(contact) = [
           #if contact.keys().contains("icon") [
            #box(image(contact.icon, width: 15pt)) #h(5pt)
            ]
         ]
         #for contact in contacts [
           #if contact.keys().contains("link") [
             #link(contact.link)[
              #box[#addIcon(contact) #underline[#contact.content]]
             ]
           ] else [
             #addIcon(contact) #contact.content
           ]
           #h(5pt) | #h(5pt)
         ]
    ]
    #let header-text = [
      #table(  
        columns: 1fr,
        inset: 0pt,
        stroke: none,
        row-gutter: 6mm,
        [ #first-name-header-section #surname-header-section ], [#create-contact-info]
      )
    ]


      #table(
        columns: (auto, 25%),
        inset: 0pt,
        stroke: none,
        column-gutter: 15pt,
        align: left + horizon,
        [#header-text], [#box[ #image(photo, width: 150pt, height: 150pt)]]
      )
    
  ]
  
  // \header
  
  
  create-header

  body
}



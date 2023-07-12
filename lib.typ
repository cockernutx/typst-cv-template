
#let contacts = (
  (content: [johndoe], link: "https://github.com/johndoe", icon: "icons/github-mark.svg"), 

  (content: [#"johndoe@johndoemail.com"], icon: "icons/email-svgrepo-com.svg", link: "mailto:johndoe@johndoemail.com")
)

#let cv_template(firstName: "John", surname: "Doe", contacts: contacts, photo: "icons/blank-image.svg", body) = {
  set text(font: "Cascadia Code", size: 10pt)
  set page(
    paper: "a4",
    margin: (
      left: 1cm,
      right: 1cm,
      top: .8cm,
      bottom: .8cm,
    ),
  )
  
  show heading: it => [
    #set text(
      font: "IBM Plex Mono",
      weight: "medium",
      fill: rgb("#474747"),
      size: 25pt,
      spacing: 1pt
    )
    #let si = 0

    #box(it) #h(10pt) #box([#line(length: 100%, stroke: 1.5pt) #v(6pt)], width: 1fr) #linebreak()
  ]
  
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
        #set text(size: 12pt)
      
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
        [#header-text], [#box[ #image(photo, fit: "cover")]]
    )
    
  ]
  
  // \header
  
  
  create-header
  linebreak()
  linebreak()
  body
}

#let skill(description, place, timeframe, img: "") = {
  set text(font: "Public Sans")
  
  let time = [
    #set text(fill: rgb("#ff3d3d"), size: 11pt)
    #set align(right)

    #emph(upper(timeframe))
  ]

  let desc = [
    #set text(weight: "bold", size: 13pt)
    #description
  ]

  let plc = [
    #set text(fill: rgb("#45a5e6"), weight: "semibold")
    #upper(place)
  ]

  if img != "" [
  
    #let i = image(img, fit: "contain")
    #box(height: 25pt)[#i] #h(10pt)
    #box()[#grid(gutter: 10pt, [#desc], [#plc])] #h(15pt) 
    #box([#line(length: 100%, stroke: 0.3pt) #v(20pt)], width: 1fr) #h(15pt)  
    #box()[#time #v(16.5pt)]
  
  ]
  else [
    #box()[#grid(gutter: 10pt, [#desc], [#plc])] #h(15pt) 
    #box([#line(length: 100%, stroke: 0.3pt) #v(20pt)], width: 1fr) #h(15pt)  
    #box()[#time #v(16.5pt)]
  ]
}

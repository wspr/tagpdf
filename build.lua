-- Build script for tagpdf
packageversion="0.2"
packagedate="2018/07/09"

module   = "tagpdf"
ctanpkg  = "tagpdf"

checkengines = {"pdftex", "luatex"}
checkconfigs = {"build"}
checkruns = 3

pdfext=""

sourcefiledir = "./source"

tagfiles = {"*.md",
            "**/*.sty",
            "**/*.def",
            "**/*.lua"}

function update_tag (file,content,tagname,tagdate)
 tagdate = string.gsub (packagedate,"-", "/")
 if string.match (file, "%.sty$" ) then
  content = string.gsub (content,  
                         "\\ProvidesExplPackage {(.-)} {.-} {.-}",
                         "\\ProvidesExplPackage {%1} {" .. tagdate.."} {"..packageversion .. "}")
  return content                         
 elseif string.match (file, "%.def$") then
  content = string.gsub (content,  
                         "\\ProvidesExplFile {(.-)} {.-} {.-}",
                         "\\ProvidesExplFile {%1} {" .. tagdate.."} {"..packageversion .. "}")                         
  return content                         
 elseif string.match (file, "%.md$") then
   content = string.gsub (content,  
                         "Packageversion: %d%.%d",
                         "Packageversion: " .. packageversion )
   content = string.gsub (content,  
                         "Packagedate: %d%d%d%d/%d%d/%d%d",
                         "Packagedate: " .. tagdate )                      
   return content
 elseif string.match (file, "%.lua$" ) then
   content = string.gsub (content,  
                         "Packageversion: %d%.%d",
                         "Packageversion: " .. packageversion )
   content = string.gsub (content,  
                         "Packagedate: %d%d%d%d/%d%d/%d%d",
                         "Packagedate: " .. tagdate )                      
   return content
 end
 return content
 end

-- ctan setup
docfiles = {"source/tagpdf.bib", "source/examples/**/*.tex", "source/examples/**/*.pdf"}
textfiles= {"source/README.md"}
packtdszip   = false
installfiles = {
                "**/*.sty",
                "**/*.def",
                "**/*.lua"
               }  
               
sourcefiles  = {
                "**/*.sty",
                "**/*.def",
                "**/*.lua"
               }
                            
typesetfiles = {"source/tagpdf.tex"}

kpse.set_program_name ("kpsewhich")
if not release_date then
 dofile ( kpse.lookup ("l3build.lua"))
end

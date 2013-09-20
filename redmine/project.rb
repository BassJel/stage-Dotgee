require 'nokogiri'

class XMLNokogiri
 
  attr_accessor :myDoc
 
  def initialize(myFileName)
    loadXML(myFileName)
  end
 
  def loadXML(myFileName)
 
    begin
      myFile = File.new(myFileName)
    rescue
      puts "Can't open the file. Please check the name: " + myFileName + ". Try it again: "
      myFileName = gets.chomp
      retry
    end
 
    @myDoc = Nokogiri::XML(myFile)
 
  end
 
  def readXML()
 
    # Get a node (or many)
    for gecko in @myDoc.root.xpath("//entry")
 
      # Get an attribute
      # puts gecko['name']
 
      # Get a text
      puts "\t" + gecko.xpath("./title").text
      puts "\t" + gecko.xpath("./link").text
      puts "\t" + gecko.xpath("./id").text
      puts "\t" + gecko.xpath("./updated").text
      puts "\t" + gecko.xpath("./content").text
      puts "\n"
 
    end
 
  end
 
  def searchNode(xpathExpr)
 
    myNode = @myDoc.at(xpathExpr)
 
    if(myNode == nil)
      puts "Not found..."
    else
      puts myNode.to_xml
      return myNode
    end
 
  end
 
  def insertAChildNode(docPosition, myNode)
    docPosition.add_child(myNode)
  end
 
  def addARootNode(myNode)
    @myDoc.root = myNode
  end
 
  def createANewNode(name)
    return Nokogiri::XML::Node.new(name, @myDoc)
  end
 
  def addAnAttribute(myNode, name, value)
    myNode[name] = value
  end
 
  def addText(myNode, text)
    myNode.content = text.to_s
  end
 
  def createANewDoc()
    myNewDoc = Nokogiri::XML::Document.new
  end
 
  def saveToFile(myfileName)
 
    begin
      myFile = File.new(myfileName)
    rescue
    end
 
    myFile = File.open(myfileName, 'w')
    @myDoc.write_xml_to(myFile, 4,'UTF-8')
    myFile.close
 
  end
 
end
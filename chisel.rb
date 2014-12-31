require 'pry'
class Chisel

  # Chunks are important
  # Find a programmatic way to determine header size (look into ruby's count method)
  def paragraph(document)
    document = '<p>' + document + '</p>'
  end

  def lined(document)
    html = []
    lines = document.split("\n")
    lines.each do |line|
      html << new_line
    end
    html.join("\n")
  end

  def line_break(document)
      list =  document.split("\n")
      lines = list.map do |line|
        line.gsub(/\s+/, "")
      end
      lines.join("\n")
  end

  def chunkify(document)
    lines = document.split("\n")
    chunks =  lines.map do |line|
      line.gsub /^$\n/, ''
      end
    chunks
  end

  def strong(document)
    words = document.split(' ')
    emphasized = words.map do |word|
      if word.start_with?('**')
        emph = word.gsub("**",'<strong>')
        emph = emph.insert(-8, '/')
      end
    end
    emphasized.join(' ')
  end

  def header(document)
    if document[0..2] == '###'
      markdown = document.gsub('###', '<h3>')
      markdown + "</h3>"
    elsif document[0..1] == "##"
      markdown = document.gsub('##', '<h2>')
      markdown + "</h2>"
    else
      markdown = document.gsub('#', '<h1>')
      markdown + "</h1>"
    end
  end

  def emphasize(document)
    words = document.split(' ')
    emphasized = words.map do |word|
        emph = word.gsub("*",'<em>')
        emph = emph.insert(-4, '/')
    end
        emphasized.join(' ')
  end

  def unordered_lists(document)
    # *_
    lines = document.split("\n")
    items = lines.map do |line|
        li = line.gsub("* ",'<li>') + "</li>"
    end
    list = items.join("\n")
    '<ul>' + list + "\n</ul>"
  end

  def parse(document)

    if document.include?("\n")
      lines = line_break(document)
    end

    if document =~ /^[A-Z]/
      list = paragraph(document)
    end
  end

 end

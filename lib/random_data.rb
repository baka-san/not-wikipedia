module RandomData

  def self.random_paragraph(sentence) 
    sentences = []

    rand(4..8).times do
      sentences << sentence.call
    end

    sentences.join(" ")
  end


  def self.random_body(sentence)
    paragraphs = []

    rand(4..8).times do
      paragraph = random_paragraph(sentence)
      paragraphs << paragraph
    end

    paragraphs.join("\n\n")
  end

end
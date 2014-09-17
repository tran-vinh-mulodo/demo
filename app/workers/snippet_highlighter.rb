require 'net/http'
class SnippetHighlighter
  @queue = :snippets_queue

  def self.perform(data)
    (1..20).each {|e|
      uri = URI.parse('http://localhost:3000/export/send_mail')
      request = Net::HTTP.post_form(uri, data)
      puts request.body
    }
  end
end
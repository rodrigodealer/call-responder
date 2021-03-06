Gem::Specification.new do |s|
  s.name        = 'call-responder'
  s.version     = '0.0.3'
  s.date        = '2013-08-10'
  s.summary     = "Call responder"
  s.description = "A simple gem that creates a responder that makes a request for a service, with the HTML content as parameter and responds the stream of the response."
  s.authors     = ["Rodrigo Oliveira"]
  s.email       = 'rodrigo.dealer@gmail.com'
  s.files       = ["lib/call_responder.rb"]
  s.add_dependency "actionpack", "~> 4.2.5.1"
  s.add_dependency "rest-client", "~> 1.8.0"
  s.homepage    =
    'https://github.com/rodrigodealer/call-responder'
  s.license       = 'MIT'
end

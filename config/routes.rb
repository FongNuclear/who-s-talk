Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
  	get '/whostalk/eat', to: 'whostalk#eat'
  	get '/whostalk/request_headers', to: 'whostalk#request_headers'
  	get '/whostalk/request_body', to: 'whostalk#request_body'
  	get '/whostalk/response_headers', to: 'whostalk#response_headers'
  	get '/whostalk/response_body', to: 'whostalk#show_response_body'
  	get '/whostalk/sent_request', to: 'whostalk#sent_request'
  	post '/whostalk/webhook', to: 'whostalk#webhook'
  end
end

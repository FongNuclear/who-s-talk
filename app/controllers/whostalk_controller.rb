require 'line/bot'
class WhostalkController < ApplicationController
	protect_from_forgery with: :null_session

	def eat
		render plain: "吃土"
	end
	def request_headers
		render plain: request.headers.to_h.reject{ |key, value| key.include? '.'}.map{ |key, value| "#{key}: #{value}"}.sort.join("\n")
	end
	def request_body
		render plain: request.body
	end
	def response_headers
		response.headers['5566'] = 'QQ'
		render plain: response.headers.to_h.map{ |key, value| "#{key}: #{value}"}.sort.join("\n")
	end
	def show_response_body
		puts "====這是設定前的response.body:#{response.body}===="
		render plain: "虎哇哈哈哈哈哈"
		puts "====這是設定後的response.body:#{response.body}===="
	end
	def sent_request
    	uri = URI('http://localhost:3000/whostalk/eat')
    	http = Net::HTTP.new(uri.host, uri.port)
    	http_request = Net::HTTP::Get.new(uri)
    	http_response = http.request(http_request)

    	render plain: JSON.pretty_generate({
      		request_class: request.class,
      		response_class: response.class,
      		http_request_class: http_request.class,
      		http_response_class: http_response.class
    	})
  end
    def translate_to_korean(message)
    	"#{message}油"
    end
	def webhook
		# Line Bot API物件初始化
		client = Line::Bot::Client.new{ |config|
			config.channel_secret =  '19a40892a2ea08a6e16d5a82db4d08f9'
			config.channel_token = 'KymUKUDvj3hSGNiA6kpWWbzNwC9qKsiOlzSOU8xUisEjmArbTtfITt3ElZ38bV5E4/Ds1IFp4jnOJl7g2a3G7YezHvAsrIAhXCwx57JVLUQtz/KHAtguD+rc/q02CbAN6xmZWN++dmiMgXP4Und9RwdB04t89/1O/w1cDnyilFU='			
		}

		#取得reply token
		reply_token = params['events'][0]['replyToken']

		#設定回覆訊息
		message = {
			type: 'text',
			text: 'OH~ YES~'
		}

		#傳送訊息
		response = client.reply_message(reply_token, message)

		#回應200
		head :ok
	end

end

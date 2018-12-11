require 'line/bot'
class WhostalkController < ApplicationController
	protect_from_forgery with: :null_session

	def webhook
		#學說話
		reply_text = learn(received_text)
		#設定回覆訊息
		reply_text = keyword_reply(received_text) if reply_text.nil?

		#傳送訊息到LINE
		response = reply_to_line(reply_text)
		
		#回應200
		head :ok
	end

	#學說話
	def learn(received_text)
		#如果開頭不是 鬍子狗學說話; 就跳出
		return nil unless received_text[0..6] == '鬍子狗學說話;'
		
		received_text = received_text[7..-1]
		semicolon_index = received_text.index(';')

		#找不到分號就跳出
		return nil if semicolon_index.nil?

		keyword = received_text[0..semicolon_index-1]
		message = received_text[semicolon_index+1..-1]

		KeywordMapping.create(keyword: keyword, message: message)
		'OH~ YES~'
	end

	#取得對方說的話
	def received_text
		message = params['events'][0]['message']
		message['text'] unless message.nil?
			
	end

	def keyword_reply(received_text)
		mapping = KeywordMapping.where(keyword: received_text).last
		if mapping.nil?
			nil
		else
			mapping.message
		end

	end

	#傳訊息到LINE
	def reply_to_line(reply_text)
		return nil if reply_text.nil?

		#取得reply token
		reply_token = params['events'][0]['replyToken']

		#設定回覆訊息
		message = {
			type: 'text',
			text: reply_text
		}

        #傳送訊息
		line.reply_message(reply_token, message)
	end

	#line bot api 物件初始化
	def line
		@line ||= Line::Bot::Client.new{ |config|
			config.channel_secret =  '19a40892a2ea08a6e16d5a82db4d08f9'
			config.channel_token = 'KymUKUDvj3hSGNiA6kpWWbzNwC9qKsiOlzSOU8xUisEjmArbTtfITt3ElZ38bV5E4/Ds1IFp4jnOJl7g2a3G7YezHvAsrIAhXCwx57JVLUQtz/KHAtguD+rc/q02CbAN6xmZWN++dmiMgXP4Und9RwdB04t89/1O/w1cDnyilFU='			
		}
	end
	
	
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

	

end

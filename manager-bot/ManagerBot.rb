require 'telegram/bot'

class ManagerBot
  def initialize(token, invite)
    @token = token
    @invite = invite
  end

  def run()
    Telegram::Bot::Client.run(@token) do |bot|
      @bot = bot
      puts 'Running ManagerBot!'
      
      bot.listen do |message|
        # p message.from.id
        # p message.from.first_name
        begin
          case message.text
          when '/help'
            puts 'entrou help'
            self.answer_command(message.chat.id, self.method(:handle_help))
          when '/channel'
            self.answer_command(message.chat.id, self.method(:handle_channel))
          when '/register'
            self.answer_command(message.chat.id, self.method(:handle_register))
          when '/delete'
            self.answer_command(message.chat.id, self.method(:handle_delete))
          when '/start'
            self.answer_command(message.chat.id, self.method(:handle_start))
          else
            self.answer_command(message.chat.id, self.method(:handle_other))
          end
        rescue => exception
          puts 'Algum erro ocorreu.'
        end
      end
    end 
  end

  private def handle_help()
    "Comandos disponíveis:\n
    /start - Mensagem de boas vindas;
    /help - Mensagem com comandos;
    /channel - Obter convite do canal de notícias do telegram;
    /register {SEU_EMAIL} - Registrar na newsletter via e-mail;
    /delete - Deletar seu e-mail da newsletter via e-mail;"
  end

  private def handle_channel()
    "Receba notícias de tecnologia diariamente em nosso canal!\n #{@invite}"
  end

  private def handle_register()
    'answering register'
  end 

  private def handle_delete()
    'answering delete'
  end

  private def handle_start()
    "Olá! Eu sou Terubynho, bot responsável pela Terubytes Newsletter!\n\nA Terubytes Newsletter te entrega todos os dias as notícias mais relevantes do mundo da tecnologia, e você pode receber as manchetes de duas maneiras:\n
      - Pelo nosso canal do telegram;
      - Por e-mail;\n\nDigite /help para mais informações."
  end

  private def handle_other()
    "Instrução inválida, amigo! Digite /help para ver os comandos disponíveis."
  end

  private def answer_command(chat, handle_method)
    answer = handle_method.call()
    @bot.api.send_message(chat_id: chat, text: answer)
  end
end

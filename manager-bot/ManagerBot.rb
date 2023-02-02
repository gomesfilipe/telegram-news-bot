require 'telegram/bot'
require 'rest-client'

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
        begin
          case message.text
          when '/help'
            self.answer_command(message.chat.id, self.method(:handle_help))
          when '/channel'
            self.answer_command(message.chat.id, self.method(:handle_channel))
          when /^(\/register) (\S+)$/
            email = $2
            id_telegram = message.from.id
            name = message.from.first_name
            
            self.answer_command(message.chat.id, self.method(:handle_register), email, id_telegram, name)
          when '/delete'
            id_telegram = message.from.id
            self.answer_command(message.chat.id, self.method(:handle_delete), id_telegram)
          when '/start'
            self.answer_command(message.chat.id, self.method(:handle_start))
          else
            self.answer_command(message.chat.id, self.method(:handle_other))
          end
        rescue => exception
          puts exception
          puts 'Algum erro ocorreu.'
        end
      end
    end 
  end

  private def handle_help(args)
    "Comandos disponíveis:\n
    /start - Mensagem de boas vindas;
    /help - Mensagem com comandos;
    /channel - Obter convite do canal de notícias do telegram;
    /register {SEU_EMAIL} - Registrar na newsletter via e-mail;
    /delete - Deletar seu e-mail da newsletter via e-mail;"
  end

  private def handle_channel(args)
    "Receba notícias de tecnologia diariamente em nosso canal!\n #{@invite}"
  end

  private def handle_register(args)
    email = args[0]
    id_telegram = args[1]
    name = args[2] 
    email_regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
    
    begin
      if email.match(email_regex)
        res = RestClient.post(
          "http://localhost:3000/users", 
          {
            'email' => email,
            'id_telegram' => id_telegram,
            'name' => name
          }.to_json,
          {
            content_type: :json,
            accept: :json
          }
        )
        return 'Cadastro na Newsletter efetuado com sucesso!'
      else
        raise 'Endereço de e-mail inválido. Tente novamente.'
      end
    rescue => exception
      return "Algum erro ocorreu dentre as opções abaixo:
        - Email inválido;
        - Email já cadastrado na newsletter;
        - Você ja está cadastrado na newsletter;\n\nTente novamente."
    end
  end 

  private def handle_delete(args)
    id_telegram = args[0]

    begin
      res = RestClient.delete("http://localhost:3000/users/#{id_telegram}")
      return "Você não receberá mais as notícias :("
    rescue => exception
      return "Você não está cadastrado na Newsletter para ser deletado!"
    end
  end

  private def handle_start(args)
    "Olá! Eu sou Terubynho, bot responsável pela Terubytes Newsletter!\n\nA Terubytes Newsletter te entrega todos os dias as notícias mais relevantes do mundo da tecnologia, e você pode receber as manchetes de duas maneiras:\n
      - Pelo nosso canal do telegram;
      - Por e-mail;\n\nDigite /help para mais informações."
  end

  private def handle_other(args)
    "Instrução inválida, amigo! Digite /help para ver os comandos disponíveis."
  end

  private def answer_command(chat, handle_method, *args)
    answer = handle_method.call(args)
    @bot.api.send_message(chat_id: chat, text: answer)
  end
end

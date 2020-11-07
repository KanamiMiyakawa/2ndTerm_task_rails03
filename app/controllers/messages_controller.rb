class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    # indexアクションに書かれたこれらの記載は、
    # 一つ一つの部分で何をしているかの理解をわかりやすくするために
    # このような記載にしていますが、実戦で用いるのには少々冗長なコードとなっているので
    # 余力のある人はコードのリファクタリングにも挑戦してみましょう！
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end
    #[:m]はlink_toに付属するクエリパラメータ、おそらく全件表示？
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    #もし最後のメッセージが存在し、自分のIDでなければ、今移っているメッセージをすべて既読に
    #.update_allは全件更新のメソッド
    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end
    @messages = @messages.order(:created_at)
    #新規投稿用のインスタンス変数を作成
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      render 'index'
    end
  end

  private
  
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end

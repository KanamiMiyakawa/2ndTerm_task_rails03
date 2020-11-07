class Conversation < ApplicationRecord
  # 会話はUserの概念をsenderとrecipientに分けた形でアソシエーションする。
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  # 一つの会話はメッセージをたくさん含む一対多。
  has_many :messages, dependent: :destroy
  # [:sender_id, :recipient_id]が同じ組み合わせで保存されないようにするためのバリデーションを設定。
  validates_uniqueness_of :sender_id, scope: :recipient_id
  # =?は,その直前にあるオブジェクトの中に、後ろのカンマで区切られたsender_idなどに代入された値と同じものがあるか調べる
  # この場合、１つめの=?は１つめのカンマの後ろのsender_idと同じものがないか探しているのだと思う
  # また、sender_id,recipient_idの前後がいれかわってもOK
  # つまり、引数にある２つのidが入っているconversationsのレコードを探しているということ
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND  conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end
  # 下記で解説
  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end
end

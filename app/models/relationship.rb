class Relationship < ApplicationRecord
  #今までbelogs_toのうしろはテーブル名だったが、今回はアソシエーションに依存している
  #class_nameでどのテーブルに存在するアソシエーションか決定
  belongs_to :followed, class_name: "User"
  belongs_to :follower, class_name: "User"
end

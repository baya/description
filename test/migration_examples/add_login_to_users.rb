# -*- coding: utf-8 -*-
class AddLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login,  :string              # 登陆名 gender
    add_column :users, :gender, :intger, default: 0  # 性别 0 女 1 男 nickname
    add_column :users, :age, :intger
    rename_column :users, :name, :nickname           # 昵称
  end
end

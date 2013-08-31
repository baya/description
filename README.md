# Description

Description help us to extract database schema doc from migration files



## Install
`git clone https://github.com/baya/description.git`
`cd description`
`bundle install`


## Usage

In the description dir, execute following code,

`bin/describe /path/to/your/rails-app` and then use browser to visit http://localhost:9393

## Features

Description could be able to parse following ruby code

```ruby
  class CreateContests < ActiveRecord::Migration
	def change
	  create_table :contests do |t|
		t.integer    :itype, default: 0, null: false  # 比赛形式, 0 photo, 1 video, 2 word, 3 audio, 4 组合
		t.integer    :mode, default: 0, null: false   # 是否可加入比赛, 0 pk, 1 调查, 2 多选
		t.integer    :format, default: 0, null: false # 比赛方式, 1 pk, 0 binary(传统比赛)
		t.date       :start_day                       # 比赛开始日期
		t.integer    :length                          # 比赛时长以天为单位
		t.integer    :vote_right                      # 投票权, 0 public, 1 friends only, 2 specific
		t.integer    :contestant_right                # 参赛权, 0 public, 1 friedns only, 2 specific
		t.string     :logo                            # 比赛logo,图片
		t.timestamps
	  end
	end
end

```

to a markdown table like following,

### contests
Column           | Type    | Modifiers             | Comment                                        
---------------- | ------- | --------------------- | -----------------------------------------------
start_day        | date    |                       | 比赛开始日期                                         
length           | integer |                       | 比赛时长以天为单位                                      
vote_right       | integer |                       | 投票权, 0 public, 1 friends only, 2 specific      
contestant_right | integer |                       | 参赛权, 0 public, 1 friedns only, 2 specific      
logo             | string  |                       | 比赛logo,图片                                      
itype            | integer | default:0, null:false | 比赛形式, 0 photo, 1 video, 2 word, 3 audio, 4 组合  
mode             | integer | default:0, null:false | 是否可加入比赛, 0 pk, 1 调查, 2 多选                      
format           | integer | default:0, null:false | 比赛方式, 1 pk, 0 binary(传统比赛)                     


# [アニメショップ巡り](https://apps.apple.com/us/app/%E3%82%A2%E3%83%8B%E3%83%A1%E3%82%B7%E3%83%A7%E3%83%83%E3%83%97%E5%B7%A1%E3%82%8A/id1526977940?mt=8)
家の近くや旅行先、帰省先などで簡単にアニメショップを探すことができるアプリです。

![location](https://user-images.githubusercontent.com/67212981/90326417-114b8480-dfc3-11ea-8fd6-c3298305d18f.gif)
![timeLine](https://user-images.githubusercontent.com/67212981/90326384-c7fb3500-dfc2-11ea-96df-d04d5465b21b.gif)



## 機能

* ログイン、アカウント作成、ログアウト機能  
タイムライン機能を使用するためにはログイン、アカウント作成が必要です。

* マップ機能  
現在地を取得し、近くのアニメショップをマップで探すことができます。

* エリア検索  
都道府県からアニメショップを探すことができます。

* タイムライン機能  
アニメショップの情報を投稿することで、このアプリを使っている他のユーザーに情報を共有することができます。



## 使用した技術
* 開発環境  
  * xcode
* 使用言語
  * Swift
* DB
  * Firebase Realtime Databse
  * UserDefaults
* ライブラリ
  * Firebase Auth,Storage,Messaging
  * SVProgressHUD
  * SDWebImage
  * CropViewController




## 製作者
* [Twitter](https://twitter.com/Y47125069)
* [Qiita](https://qiita.com/key652)
* [Wantedly](https://www.wantedly.com/users/133512652)



## 工夫した点
* MVCでの実装。
* 小さな店まで登録したかったので全て手打ちで店情報を入力しました。(現在227店舗)
* ブロック機能とエリア検索機能の実装は仕組みを作り上げるのが難しかったのでコードを書くのに苦労しました。



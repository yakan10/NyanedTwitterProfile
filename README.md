# これは何？
TwitterのProfile欄が毎日Nyanedされます。  
Nyanedの起点は、あなたがTwitterを始めた日です。

# Setup

## 必要なパッケージのインストール
このスクリプトでは以下のパッケージを使っています。  

* twurl (認証およびリクエストの送信)
* nkf (urlエンコード)
* jq (プロフィール取得時のjson解析)
 
```
$ gem install twurl
$ brew install nkf # MacOSXの場合
$ brew install jq # MacOSXの場合
```

(gemを使うためrubyを入れておいてください）

## TwitterアプリのSetup
以下のページでTwitterアプリを作成して、Consumer Key, Consumer Secretを入手します。  
https://apps.twitter.com  
これらの情報はアプリ作成後「Keys and Access Tokens」タブから入手できます。


## twurlにConsumerKeyとConsumerSecretを登録
先ほど入手したConsumer KeyとConsumer Secretを以下のように登録します。

```
$ twurl authorize --consumer-key key       \
                  --consumer-secret secret
```

OAuth認証用のURLが表示されるので、ブラウザでアクセスしてアプリを許可します。  
表示されたPINをコンソールに入力します。  
「Authorization successful」と表示されれば成功です。

## シェルスクリプトのTwitterIDを編集
nyaned_twitter_profile.shの4行目のSCREEN_NAMEを自分のTwitterのユーザー名に変更。  
必要に応じて5行目のlogディレクトリも編集。

```nyaned_twitter_profile.sh
SCREEN_NAME="your_screen_name"
LOGDIR="./log"
```

## crontabで毎日実行するように設定
```
$ sudo crontab -e
```

```crontab
 0 0 * * * sh /path/to/crontab/nyaned_twitter_profile.sh
```
保存。  
これで、毎日0時にプロフィール欄が更新されます。

# 参考
* https://developer.twitter.com/
* シェルスクリプト（Bash）で作るTwitterクライアント
　https://qiita.com/piroor/items/a999eeef9a67283b1e56
* http://sechiro.hatenablog.com/entry/2015/01/25/シェルスクリプトの中で変数を分割する際には、cut
* Perl 時刻計算 Tips
  http://d.hatena.ne.jp/perlcodesample/20081014/1224168958
  
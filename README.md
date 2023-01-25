# clean_architecture_sample

A sample of clean architecture.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Directory
- main.dart : DIやインフラの初期化、およびアプリの初期化を実装する。
- domain : ビジネスロジックの実装箇所。どこにも依存しない。
  - data : repositoryで利用する各種サービスのインターフェースを配置する。
  - entity : ビジネスロジックで利用するエンティティを実装する。
  - event : ビジネスロジックの処理の結果発生したイベントを流す。domain内ではイベントを流すだけで監視しない。
  - repository : dataディレクトリ内のインターフェースをもとにエンティティを操作する処理を組み立てるサービスを実装する。
  - use_case : 一つの関心ごとを行うための呼び出し口となるユースケースをrepositoryを組み合わせて実装する。一つの関心ごとが対象なので、各クラスのメソッドは一つだけ。
- infra : OSに依存する実際の実装を配置する箇所。
  - data : domain/dataのインターフェースを実装する箇所。これ以外はinfra下に作る。
    - \<data source>\ : 取得元の実装箇所。
      - model : 取得元から取得したデータを実装する。
        - mapper : 取得したデータをドメインのエンティティに変換を行う。\<infraのmodel\>Mapperというクラス名で実装する。
- presentation : UIに関する実装を行う箇所。
  - interactor : use_caseを組み合わせてアプリケーションロジックを実装した機能サブセットを提供する。組み合わせるuse_caseが一つでも実装する。
  - model : UIで表示するためのモデル。
    - dto : presentation/modelにドメインのエンティティから変換する。\<presentationのmodel\>Dtoというクラス名で実装する。
  - presenter : screenで実装した画面の操作モデルをinteractorを組み合わせて実装する。画面更新を行うためにProviderかStreamの組み合わせで実装する。また、domain/eventのイベント監視も必要なら行う。
  - screen : widgetで実装したWidgetを組み合わせてStatelessWidgetで実装した画面を実装する。画面の操作と状態はpresenterで実装＆保持する。
  - widget : 基本的なWidgetやカスタムWidgetを実装する箇所。基本的に状態は持たない。状態を持ちたいならコントローラを実装する。
- utility : どこからでも参照されうるOS非依存の共通の実装。OSに依存したい場合はここでインターフェースを実装してinfraに実装する。
  - enum : UIに関係しないenumを実装する。 
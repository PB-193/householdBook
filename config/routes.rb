Rails.application.routes.draw do
    resources :books
    post "/books/:id" => "books#update" 

    root to: "books#index"
    
    # get "/books" => "books#index"
    # post "/books" => "books#create"
    # get "/books/new" => "books#new" , as:"new_book"
    # get "/books/:id/edit" => "books#edit" , as:"edit_book"
    # get "/books/:id" => "books#show" , as:"book"
    
    # ニックネームを書いていないですが書いていない場合は、すぐ上のニックネーム(book)を引き継ぎます。
    # showと同じニックネーム・URLパターンになってしまいますが、HTTPメソッドが異なるのでちゃんと区別されます。
    # delete "/books/:id" => "books#destroy"
end

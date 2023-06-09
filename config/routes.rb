Rails.application.routes.draw do
    resources :books do
        delete 'destroy_all', on: :collection
    post "/books/:id" => "books#update"
        resources :comments, only: [:new, :create, :destroy]
    end
    
    resources :comments, only: [:destroy]

    get "/signup" => "users#new"
    post "/signup" =>"users#create"
    get "signin" => "session#new"
    post "signin" => "session#create"
    get "signout" => "session#destroy"
    get "users/edit" => "users#edit", as: "edit_user"
    patch "users/" => "users#update" , as: "user"
    get "users/:id/show" => "users#show", as: "show_user"
    
    post '/guest_login', to: 'sessions#guest_login'

    root to: "homes#top"
    get 'homes/about'

    # get "/books" => "books#index"
    # post "/books" => "books#create"
    # get "/books/new" => "books#new" , as:"new_book"
    # get "/books/:id/edit" => "books#edit" , as:"edit_book"
    # get "/books/:id" => "books#show" , as:"book"

    # ニックネームを書いていないですが書いていない場合は、すぐ上のニックネーム(book)を引き継ぎます。
    # showと同じニックネーム・URLパターンになってしまいますが、HTTPメソッドが異なるのでちゃんと区別されます。
    # delete "/books/:id" => "books#destroy"
end

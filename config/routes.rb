Rails.application.routes.draw do

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

    root 'home#index'

    get '/maintenance' => "home#maintenance"

    resources :posts, path: 'news-and-analysis' do
      put :publish
      put :featured
      put :pinned
      collection do
        get :preview
      end
    end

    resources :sub_sections

    resources :sections

    resources :web_pages, path: "content"

    get "content/:id" => "web_pages#show", as: "content"

    get 'feed' => 'posts#feed'

    # for cms pages
    get "about/who-we-are" => "content_management_pages#who_we_are"
    get "about/what-we-do" => "content_management_pages#what_we_do"
    get "resources/how-to-appeal" => "content_management_pages#appeal"
    get "privacy-policy" => "content_management_pages#privacy"
    get "about/faqs" => "faqs#index"

    resources :people

    get "/author/:id" => "posts#author", :as => "author"

    resources :faqs

    get "resources/further-readings" => "further_reads#index"
    resources :further_reads

    resources :home_fields

    resources :stories do
      put :publish
    end

    resources :platform_links
    resources :posts_themes
    resources :categories
    resources :social_media_platforms
    resources :languages
    resources :countries

    resources :quotes do
      put :featured
    end

    resources :questions
    resources :question_options

    resources :contacts_topics
    resources :contacts , except: :index
    get "/contacts" => "contacts#new"

    # redirect old form links to the new flow
    get "/submit-report", :to => redirect("/")
    get "/submit", :to => redirect("/")
    get "/submit-report/facebook", :to => redirect("/")
    get "/submit-report/twitter", :to => redirect("/")
    get "/submit-report/flickr", :to => redirect("/")
    get "/submit-report/youtube", :to => redirect("/")
    get "/submit-report/google", :to => redirect("/")
    get "/submit-report/instagram", :to => redirect("/")

    get "/admin/stories" => "stories#index"
    get "/admin/posts" => "posts#admin"

    # for backend ######
    get "/admin", :to => redirect("/users/sign_in")
    get "/admin/dashboard" => "home#dashboard"

    get "/admin/countries" => "countries#index"
    get "/admin/languages" => "languages#index"
    get "/admin/social_media_platforms" => "social_media_platforms#index"
    get "/admin/pages_questions" => "pages#pages_questions"
    post "/admin/update_page" =>"pages#update_page"
    post "/admin/update_message" =>"pages#update_message"
    get "/admin/questions" => "questions#index"
    get "/admin/related_questions" => "questions#related_questions"
    get "/admin/related_options" => "questions#related_options"
    get "/admin/question_users" => "question_users#index"

    get "/admin/people" => "people#index"
    get "/admin/content_management_pages" => "content_management_pages#index"
    get "/admin/home_fields" => "home_fields#admin"
    get "/admin/categories" => "categories#index"
    get "/admin/posts_themes" => "posts_themes#index"
    get "/admin/quotes" => "quotes#index"
    get "/admin/platform_links" => "platform_links#index"
    
    get "/admin/further_reads" => "further_reads#admin"
    get "/admin/faqs" => "faqs#admin"
    get "/admin/subscribes" => "subscribes#index"
    get "/admin/contacts_topics" => "contacts_topics#index"
    get "/admin/contacts" => "contacts#index"
    get "/admin/notifications" => "notifications#index"

    resources :notifications

    resources :icons, only: %i(index new create edit update destroy) do
      patch :toggle_availability, on: :member
    end


    post "/thanks" => "questions#submit"
    get '/ty' => 'questions#ty'

    # for errors
    match "/404" =>  "home#error", via: [ :get, :post, :patch, :delete ]
    match "/500" =>  "home#error", via: [ :get, :post, :patch, :delete ]
    match "/422" =>  "home#error", via: [ :get, :post, :patch, :delete ]
    # match "*path" => "home#error", via: [ :get, :post, :patch, :delete ]

    resources :subscribes
    get "/subscribe_confirmation" => "subscribes#subscribe_confirmation"

    resources :pages_questions
    resources :question_user_submissions

    resources :content_management_pages
    resources :question_answers
    resources :question_users
    
    resources :pages

    resources :takedowns, only: %i(new create index destroy show) do
      collection do
        get "confirm/:token" => "takedowns#confirm", as: "confirm"
        get "submitted"
      end
    end
  end

  devise_for :users, :skip => [:registrations]                                        
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    put 'users' => 'devise/registrations#update', :as => 'user_registration'            
  end

end

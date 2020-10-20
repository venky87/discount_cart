Rails.application.routes.draw do
  mount API::Base, at: "/"
	mount GrapeSwaggerRails::Engine => '/swagger'
end

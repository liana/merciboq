require 'rubygems'
require 'faker'

def colorize(text, color_code)
 "\e[#{color_code}m#{text}\e[0m"
end

def red(text);      colorize(text, 31); end
def green(text);    colorize(text, 32); end
def yellow(text);   colorize(text, 33); end
def purple(text);   colorize(text, 34); end
def magenta(text);  colorize(text, 35); end
def cyan(text);     colorize(text, 36); end

namespace :db do
  desc "Fill database with sample data" 
  task populate: :environment do
     if Rails.env.development?
      puts "#{red("==>")} Clearing Current Data"
      Rake::Task['db:reset'].invoke
    end
    puts "#{green("==>")} Creating sample admin user"
    sample_admin
    puts "#{green("==>")} Creating sample users"
    make_users
    puts "#{green("==>")} Creating merciboqs"
    make_merciboqs
    puts "#{green("==>")} Creating bonds"
    make_bonds
  end
end

def sample_admin
  admin = User.new(email: "fred.schoeneman@gmail.com",
                      password: "password" )
  admin.save!
  admin.confirm!
end

def make_users
  99.times do |n|
    name = Faker::Name.name 
    email = Faker::Internet.email
    password  = "password"
    user = User.new(name: name,
                    :email => email,
                    :password => password)  
    user.save!
    user.confirm!
  end
end

def make_merciboqs
  50.times do |n|
    users = User.all(:limit => 4).each do |user|
      welcomer = n+1
      headline = Faker::Company.catch_phrase
      content = Faker::Lorem.paragraph
      merciboq = user.thankyous.create!(:welcomer_id => welcomer,
                             :content => content,
                             :headline => headline)
 #      merciboq.attachments << Attachment.new(:mimetype =>
 #  "text/plain", :filename => "foo.txt", :bytes => "Fred is the man!
 # \nrecognize, bitches!")
    end
  end
end

def make_bonds
  users = User.all
  development_user = User.find_by_email("fred.schoeneman@gmail.com")
  subordinate_users = users[2..50]
  dominant_users = users[3..40]
  subordinate_users.each do |subordinate|
    subordinate.submit!(development_user)
  end

  dominant_users.each do |dominant|
    development_user.submit!(dominant)
  end

end

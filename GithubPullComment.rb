#!/usr/bin/env ruby

require 'rubygems'
require 'octokit'
require 'trollop'

#options
opts = Trollop::options do  
    opt :username,
    "USERNAME",
    :short => '-u',
    :type => :string,
    :required => true
    
    opt :password,
    "PASSWORD",
    :short => '-p',
    :type => :string,
    :required => true
    
    opt :repo,
    'REPOSITORY',
    :short => '-r',
    :type => :string,
    :required => true

    opt :pull_request_id,
    'PULL REQUEST ID',
    :short => '-i',
    :type => :integer,
    :required => true
        
    opt :commit,
    'COMMIT SHA KEY',
    :short => '-c',
    :type => :string,
    :required => true

    opt :body,
    'COMMENT BODY',
    :short => '-b',
    :type => :string,
    :default => "Test Failed"

    opt :file,
    'FILE TO COMMENT',
    :short => '-f',
    :type => :string,
    :required => true
    
    opt :line,
    'LINE OF FILE',
    :short => '-l',
    :type => :integer,
    :default => 1
end

# Provide authentication credentials for OctoKit
Octokit.configure do |c|
  c.login = opts[:username]
  c.password = opts[:password]
end

#issue request to github API
Octokit.create_pull_request_comment(
        opts[:repo], 
        opts[:pull_request_id], "#{opts[:body]} - line #{opts[:line]}", 
        opts[:commit], 
        opts[:file], 
        opts[:line]
)
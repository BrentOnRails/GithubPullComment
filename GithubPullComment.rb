#!/usr/bin/env ruby
require 'rubygems'
require 'octokit'
require 'trollop'

#options
opts = Trollop::options do  
    #required for all types of pull request comment 
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
    'PULL REQUEST ID (aka ISSUE ID)',
    :short => '-i',
    :type => :integer
    
    opt :body,
    'COMMENT BODY',
    :short => '-b',
    :type => :string,
    :default => "Test Failed"
    
    #required for per commit comment OR in line comment (all above options required)
    opt :commit,
    'COMMIT SHA (if PER COMMIT comment)',
    :short => '-c',
    :type => :string
    
    #required for in line comment (all above options required)
    opt :file,
    'FILE TO COMMENT (if INLINE comment)',
    :short => '-f',
    :type => :string
    
    opt :line,
    'LINE OF FILE (if INLINE comment)',
    :short => '-l',
    :type => :integer
end

# Provide authentication credentials for OctoKit
Octokit.configure do |c|
  c.login = opts[:username]
  c.password = opts[:password]
end

if opts[:file] && opts[:line]
    #IN LINE COMMENT
    Octokit.create_pull_request_comment(
        opts[:repo], 
        opts[:pull_request_id],
        "#{opts[:body]} - line #{opts[:line]}", 
        opts[:commit], 
        opts[:file], 
        opts[:line]
    )
elsif opts[:commit]
    #PER COMMIT COMMENT
    Octokit.create_commit_comment(
        opts[:repo], 
        opts[:commit],
        opts[:body], 
    )
else
    #PULL REQUEST COMMENT
    Octokit.add_comment(
        opts[:repo],
        opts[:pull_request_id],
        opts[:body]
    )
end
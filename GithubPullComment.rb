#!/usr/bin/env ruby

require 'rubygems'
require 'octokit'
require 'trollop'

#options
opts = Trollop::options do  
    opt :commit,
    'COMMIT SHA',
    :short => '-c',
    :type => :string,
    :default => nil

    opt :pull_request_id,
    'PULL_REQUEST_ID',
    :short => '-i',
    :type => :integer,
    :default => nil

    opt :repo,
    'REPO',
    :short => '-r',
    :type => :string,
    :default => nil

    opt :line,
    'LINE_OF_FILE',
    :short => '-l',
    :type => :integer,
    :default => 1

    opt :body,
    'COMMENT_BODY',
    :short => '-b',
    :type => :string,
    :default => "Test Failed"

    opt :file,
    'FILE_TO_COMMENT',
    :short => '-f',
    :type => :string,
    :default => nil
    
    opt :username,
    "Username",
    :short => '-u',
    :type => :string,
    :default => nil
    
    opt :password,
    "Password",
    :short => '-p',
    :type => :string,
    :default => nil
end

# Provide authentication credentials for OctoKit
Octokit.configure do |c|
  c.login = opts[:username]
  c.password = opts[:password]
end

Octokit.create_pull_request_comment(
        opts[:repo], 
        opts[:pull_request_id], "#{opts[:body]} - line #{opts[:line]}", 
        opts[:commit], 
        opts[:file], 
        opts[:line]
)
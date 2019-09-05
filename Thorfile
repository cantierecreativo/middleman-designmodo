require "thor/group"

module Middleman
  class Generator < ::Thor::Group
    include ::Thor::Actions

    source_root File.expand_path(File.dirname(__FILE__))

    def ask_stuff
      @langs = ask("Please insert your site langs: (es. it,en)")
      @token = ask("Please insert your DatoCMS site read-only token:")
      @base_url = ask("What will be the base url of your site? (eg. https://www.mysite.com)")

      @origin = ask("What is the origin remote? (eg. git@gitlab.com:cantierecreativo/PROJECT.git)")
      @production = ask("What is the production remote? (eg. git@gitlab.com:cantierecreativo/PROJECT.git)")
    end

    def copy_default_files
      directory "template", ".", exclude_pattern: /\.DS_Store$/
    end

    def copy_optional_files
      template "optional/config.rb", "config.rb"
      template "optional/env", ".env"
      template "optional/README.md", "README.md"

      run "yarn install"
    end

    def setup_remotes
      run "git init"
      if @origin != ""
        run "git remote add origin #{@origin}"
      end
      if @production != ""
        run "git remote add production #{@production}"
      end

      run "git add ."
      run "git commit -m 'Boostrap project with template'"
    end
  end
end

require 'spec_helper'

module Setup
  
  describe "Setup" do
    
    describe "#setup_config" do
      
      context "Invalid _config.yml file" do

        it 'should raise an exception if theme is not specified.' do
          Ruhoh::Utils.should_receive(:parse_file_as_yaml).and_return({})
          lambda { Ruhoh.setup_config }.should raise_error
        end

      end
      
      context "Valid _config.yml file" do
        
        it 'should setup the config struct based on configuration input.' do
          custom_permalink = '/my/custom/link'
          custom_theme = 'table'
          custom_exclude = ['.secret']
          Ruhoh::Utils.should_receive(:parse_file_as_yaml).and_return({
            "permalink" => custom_permalink, 
            "theme" => custom_theme,
            'exclude' => custom_exclude
          })

          Ruhoh.setup_config
        
          Ruhoh.config.permalink.should == custom_permalink
          Ruhoh.config.theme.should == custom_theme
          Ruhoh.config.asset_path.should == "/_templates/themes/#{custom_theme}"
          Ruhoh.config.exclude.should == custom_exclude
        end
      
      end
      
    end
    
    describe "#setup_filters" do
      
      it 'should add custom exclude filters to the filters variable' do
        custom_exclude = ['.secret', /^test/]
        Ruhoh::Utils.should_receive(:parse_file_as_yaml).and_return({
          'theme' => "twitter",
          'exclude' => custom_exclude
        })
        Ruhoh.setup_config
        Ruhoh.setup_filters
        
        Ruhoh.filters.pages['names'].should include('.secret')
        Ruhoh.filters.pages['regexes'].should include(/^test/)
      end
      
    end
    
    describe "#setup" do
      
      it 'should setup config, paths, and filters' do
        Ruhoh.should_receive(:setup_config)
        Ruhoh.should_receive(:setup_paths)
        Ruhoh.should_receive(:setup_filters)
        Ruhoh.setup
      end
      
    end
    
  end
  
end
Pod::Spec.new do |s|
	s.name = 'SwiftHelpers'
	s.version = '7.0.5'
	s.license = 'MIT'
	s.summary = 'A collection of Swift extensions'
	s.homepage = 'git@github.com:dmiotti/SwiftHelpers.git'
	s.social_media_url = 'https://twitter.com/davidmiotti'
	s.authors = { 'David Miotti' => 'david.miotti@gmail.com' }
	s.source = { :git => 'git@github.com:dmiotti/SwiftHelpers.git', :tag => s.version }

    s.frameworks = 'UIKit', 'Foundation'

	s.source_files = 'SwiftHelpers/**/*.swift'
    
    s.swift_versions = ['5.0', '5.1']

    s.subspec 'Core' do |sp|
        sp.source_files = 'SwiftHelpers/Core'
    end

    s.subspec 'CoreData' do |sp|
        sp.source_files = 'SwiftHelpers/CoreData'
        sp.frameworks = 'UIKit', 'Foundation', 'CoreData'
    end

    s.subspec 'DateTime' do |sp|
        sp.source_files = 'SwiftHelpers/Date-Time'
    end

    s.subspec 'UI' do |sp|
        sp.source_files = 'SwiftHelpers/UI'
    end

    s.subspec 'Misc' do |sp|
        sp.source_files = 'SwiftHelpers/Misc'
    end

    s.subspec 'Basic' do |sp|
        sp.source_files = 'SwiftHelpers/Misc/SHLocalizationHelper.swift', 'SwiftHelpers/UI/SHIBInspectableExtension.swift'
    end
end

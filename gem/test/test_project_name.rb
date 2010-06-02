require 'helper'

class TestPROJECT_NAME < Test::Unit::TestCase

  should "be able to find version.yml" do
    assert(File.exists?("#{PROJECT_NAME::CONFIG_PATH}/version.yml"))
  end

  context "Test for PROJECT_NAME.version class instance method" do
    should "return 1.1.1" do
      PROJECT_NAME.version_major = 1
      PROJECT_NAME.version_minor = 1
      PROJECT_NAME.version_patch = 1
      assert_equal "1.1.1", PROJECT_NAME.version
    end
  end

  context "Tests for the PROJECT_NAME#dump_version_yaml class method." do
    should "call File.open and Yaml.dump for version.yml" do
      YAML.stubs(:dump)
      File.stubs(:open)
      File.expects(:open).once
      PROJECT_NAME.dump_version_yaml
    end
  end

  context "Tests for the PROJECT_NAME#bump class method." do

    setup do
      PROJECT_NAME.stubs(:dump_version_yaml)
    end

    should "add 1 to @version_major class instance variable, set @version_minor and @version_patch to 0 and call dump_PROJECT_NAME_version_yaml" do
      PROJECT_NAME.module_eval {@version_major = 1; @version_minor = 1; @version_patch = 1 }
      PROJECT_NAME.expects(:dump_PROJECT_NAME_version_yaml).once
      PROJECT_NAME.bump("version_major")
      assert_equal 2, PROJECT_NAME.version_major
      assert_equal 0, PROJECT_NAME.version_minor
      assert_equal 0, PROJECT_NAME.version_patch
    end

    should "add 1 to @version_minor class instance variable, set @version_patch to 0 and call dump_PROJECT_NAME_version_yaml" do
      PROJECT_NAME.module_eval {@version_major = 1; @version_minor = 1; @version_patch = 1 }
      PROJECT_NAME.expects(:dump_PROJECT_NAME_version_yaml).once
      PROJECT_NAME.bump("version_minor")
      assert_equal 1, PROJECT_NAME.version_major
      assert_equal 2, PROJECT_NAME.version_minor
      assert_equal 0, PROJECT_NAME.version_patch

    end

    should "add 1 to @version_patch class instance variable and call dump_PROJECT_NAME_version_yaml" do
      PROJECT_NAME.module_eval {@version_major = 1; @version_minor = 1; @version_patch = 1 }
      PROJECT_NAME.expects(:dump_PROJECT_NAME_version_yaml).once
      PROJECT_NAME.bump("version_patch")
      assert_equal 1, PROJECT_NAME.version_major
      assert_equal 1, PROJECT_NAME.version_minor
      assert_equal 2, PROJECT_NAME.version_patch

    end

  end

  context "Tests for the PROJECT_NAME#const_missing class method." do

    setup do
      PROJECT_NAME.stubs(:version)
    end

    should "return the value of PROJECT_NAME Version if PROJECT_NAME::VERSION is called" do
      PROJECT_NAME.expects(:version).once
      PROJECT_NAME::VERSION
    end

    should "return to super if an unknown constant is called" do
      assert_raises(NameError) {PROJECT_NAME::VERSIONS}
      assert_raises(NameError) {PROJECT_NAME::AVERSION}
    end

  end

  context "Tests for the PROJECT_NAME#method_missing class method." do

    setup do
      PROJECT_NAME.stubs(:bump).returns(:result)
      PROJECT_NAME.stubs(:dump_version_yaml)
    end

    should "recognise PROJECT_NAME#bump_version_major class instance method calls and forward them to PROJECT_NAME#bump to set @version_major." do
      PROJECT_NAME.expects(:bump).with("version_major").once
      PROJECT_NAME.bump_version_major
    end

    should "recognise PROJECT_NAME#bump_version_minor class instance method calls and forward them to PROJECT_NAME#bump to set @version_minor." do
      PROJECT_NAME.expects(:bump).with("version_minor").once
      PROJECT_NAME.bump_version_minor
    end

    should "recognise PROJECT_NAME#bump_version_patch class instance method calls and forward them to PROJECT_NAME#bump to set @version_patch." do
      PROJECT_NAME.expects(:bump).with("version_patch").once
      PROJECT_NAME.bump_version_patch
    end

    should "return method_missing to super as normal if method name is not recognised." do
      assert_raises(NoMethodError) {PROJECT_NAME.bump_version_blarg}
    end

  end

end

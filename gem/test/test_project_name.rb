require 'helper'

class TestPROJECT_NAME_CLASS < Test::Unit::TestCase

  should "be able to find version.yml" do
    assert(File.exists?("#{PROJECT_NAME_CLASS::CONFIG_PATH}/version.yml"))
  end

  context "Test for PROJECT_NAME_CLASS.version class instance method" do
    should "return 1.1.1" do
      PROJECT_NAME_CLASS.version_major = 1
      PROJECT_NAME_CLASS.version_minor = 1
      PROJECT_NAME_CLASS.version_patch = 1
      assert_equal "1.1.1", PROJECT_NAME_CLASS.version
    end
  end

  context "Tests for the PROJECT_NAME_CLASS#dump_version_yaml class method." do
    should "call File.open and Yaml.dump for version.yml" do
      YAML.stubs(:dump)
      File.stubs(:open)
      File.expects(:open).once
      PROJECT_NAME_CLASS.dump_version_yaml
    end
  end

  context "Tests for the PROJECT_NAME_CLASS#bump class method." do

    setup do
      PROJECT_NAME_CLASS.stubs(:dump_version_yaml)
    end

    should "add 1 to @version_major class instance variable, set @version_minor and @version_patch to 0 and call dump_PROJECT_NAME_CLASS_version_yaml" do
      PROJECT_NAME_CLASS.module_eval {@version_major = 1; @version_minor = 1; @version_patch = 1 }
      PROJECT_NAME_CLASS.expects(:dump_PROJECT_NAME_CLASS_version_yaml).once
      PROJECT_NAME_CLASS.bump("version_major")
      assert_equal 2, PROJECT_NAME_CLASS.version_major
      assert_equal 0, PROJECT_NAME_CLASS.version_minor
      assert_equal 0, PROJECT_NAME_CLASS.version_patch
    end

    should "add 1 to @version_minor class instance variable, set @version_patch to 0 and call dump_PROJECT_NAME_CLASS_version_yaml" do
      PROJECT_NAME_CLASS.module_eval {@version_major = 1; @version_minor = 1; @version_patch = 1 }
      PROJECT_NAME_CLASS.expects(:dump_PROJECT_NAME_CLASS_version_yaml).once
      PROJECT_NAME_CLASS.bump("version_minor")
      assert_equal 1, PROJECT_NAME_CLASS.version_major
      assert_equal 2, PROJECT_NAME_CLASS.version_minor
      assert_equal 0, PROJECT_NAME_CLASS.version_patch

    end

    should "add 1 to @version_patch class instance variable and call dump_PROJECT_NAME_CLASS_version_yaml" do
      PROJECT_NAME_CLASS.module_eval {@version_major = 1; @version_minor = 1; @version_patch = 1 }
      PROJECT_NAME_CLASS.expects(:dump_PROJECT_NAME_CLASS_version_yaml).once
      PROJECT_NAME_CLASS.bump("version_patch")
      assert_equal 1, PROJECT_NAME_CLASS.version_major
      assert_equal 1, PROJECT_NAME_CLASS.version_minor
      assert_equal 2, PROJECT_NAME_CLASS.version_patch

    end

  end

  context "Tests for the PROJECT_NAME_CLASS#const_missing class method." do

    setup do
      PROJECT_NAME_CLASS.stubs(:version)
    end

    should "return the value of PROJECT_NAME_CLASS Version if PROJECT_NAME_CLASS::VERSION is called" do
      PROJECT_NAME_CLASS.expects(:version).once
      PROJECT_NAME_CLASS::VERSION
    end

    should "return to super if an unknown constant is called" do
      assert_raises(NameError) {PROJECT_NAME_CLASS::VERSIONS}
      assert_raises(NameError) {PROJECT_NAME_CLASS::AVERSION}
    end

  end

  context "Tests for the PROJECT_NAME_CLASS#method_missing class method." do

    setup do
      PROJECT_NAME_CLASS.stubs(:bump).returns(:result)
      PROJECT_NAME_CLASS.stubs(:dump_version_yaml)
    end

    should "recognise PROJECT_NAME_CLASS#bump_version_major class instance method calls and forward them to PROJECT_NAME_CLASS#bump to set @version_major." do
      PROJECT_NAME_CLASS.expects(:bump).with("version_major").once
      PROJECT_NAME_CLASS.bump_version_major
    end

    should "recognise PROJECT_NAME_CLASS#bump_version_minor class instance method calls and forward them to PROJECT_NAME_CLASS#bump to set @version_minor." do
      PROJECT_NAME_CLASS.expects(:bump).with("version_minor").once
      PROJECT_NAME_CLASS.bump_version_minor
    end

    should "recognise PROJECT_NAME_CLASS#bump_version_patch class instance method calls and forward them to PROJECT_NAME_CLASS#bump to set @version_patch." do
      PROJECT_NAME_CLASS.expects(:bump).with("version_patch").once
      PROJECT_NAME_CLASS.bump_version_patch
    end

    should "return method_missing to super as normal if method name is not recognised." do
      assert_raises(NoMethodError) {PROJECT_NAME_CLASS.bump_version_blarg}
    end

  end

end

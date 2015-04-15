require 'fileutils'
require 'httparty'
require 'json'

module Deis
  class Client
    def initialize(uri, api_key)
      @api_key = api_key
      @controller_uri = uri
      @headers = {'Authorization' => 'token %s' % @api_key}
    end

    def apps_create(app_name=nil)
      if app_name.nil?
        return post('/v1/apps')
      else
        return post('/v1/apps', { :id => app_name })
      end
    end

    def apps_destroy(app_name)
      return delete('/v1/apps/%s' % app_name)
    end

    def apps_list
      return get('/v1/apps')
    end

    def apps_info(app_name)
      return get('/v1/apps/%s' % app_name)
    end

    def apps_logs(app_name)
      return get('/v1/apps/%s/logs' % app_name)
    end

    def apps_run(app_name, command)
      return post('/v1/apps/%s/run' % app_name, {'command' => command})
    end

    def auth_register(username, password, email)
      return post('/v1/auth/register',
        {
          'username' => username,
          'password' => password,
          'email' => email
        }
      )
    end

    def auth_cancel(username, password)
      return delete('/v1/auth',
        {
          'username' => username,
          'password' => password
        }
      )
    end

    def builds_create(app_name, image)
      return post('/v1/apps/%s/builds' % app_name,
        {
          'image' => image
        }
      )
    end

    def builds_list(app_name)
      return get('/v1/apps/%s/builds' % app_name)
    end

    def certs_add(cert, key)
      return post('/v1/certs',
        {
          'certificate' => cert,
          'key' => key
        }
      )
    end

    def certs_list
      return get('/v1/certs')
    end

    def certs_remove(common_name)
      return destroy('/v1/certs/%s' % common_name)
    end

    def config_list(app_name)
      return get('/v1/apps/%s/config' % app_name)
    end

    def config_set(app_name, config)
      return post('/v1/apps/%s/config' % app_name,
        {
          'values' => config
        }
      )
    end

    def domains_add(app_name, domain)
      return post('/v1/apps/%s/domains' % app_name,
        {
          'domain' => domain
        }
      )
    end

    def domains_remove
    end

    def domains_list
    end

    def limits_list
    end

    def limits_set
    end

    def limits_unset
    end

    def ps_list
    end

    def ps_scale
    end

    def tags_list
    end

    def tags_set
    end

    def tags_unset
    end

    def keys_add
    end

    def keys_list
    end

    def keys_remove
    end

    def perms_list
    end

    def perms_create
    end

    def perms_remove
    end

    def releases_info
    end

    def releases_list
    end

    def releases_rollback
    end

    def users_list
    end

    private

    def delete(path)
      return HTTParty.post(
        '%s%s' % [@controller_uri, path],
        :headers => @headers)
    end

    def get(path)
      return HTTParty.get(
        '%s%s' % [@controller_uri, path],
        :headers => @headers)
    end

    def post(path, data=nil)
      return HTTParty.post(
        '%s%s' % [@controller_uri, path],
        :body => body,
        :headers => @headers)
    end
  end
end

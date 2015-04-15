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

    def admins_list
      return get('/v1/admin/perms')
    end

    def admins_promote(username)
      return post('/v1/admin/perms',
        {
          'username' => username
        }
      )
    end

    def admins_demote(username)
      return delete('/v1/admin/perms/%s' % username)
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

    def domains_remove(app_name, domain)
      return delete('/v1/apps/%s/domains/%s' % [app_name, domain])
    end

    def domains_list(app_name)
      return get('/v1/apps/%s/domains' % app_name)
    end

    def ps_list(app_name)
      return get('v1/apps/%s/containers' % app_name)
    end

    def ps_scale(app_name, types)
      return post('v1/apps/%s/containers' % app_name, types)
    end

    def keys_add(id, type, key)
      return post('/v1/keys',
        {
          'id' => id,
          'public' => '%s %s' % [type, key],
        }
      )
    end

    def keys_list
      return get('/v1/keys')
    end

    def keys_remove(key)
      return delete('/v1/keys/%s' % key)
    end

    def perms_list(app_name)
      return get('/v1/apps/%s/perms' % app_name)
    end

    def perms_create(app_name, username)
      return post('/v1/apps/%s/perms' % app_name,
        {
          'username' => username
        }
      )
    end

    def perms_remove(app_name, username)
      return delete('/v1/apps/%s/perms/%s' % [app_name, username])
    end

    def releases_info(app_name, release)
      return get('/v1/apps/%s/releases/%s' % [app_name, release])
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

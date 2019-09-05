page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

set :url_root, ENV.fetch('BASE_URL')

ignore '/templates/*'

config[:images_dir] = 'i'

<%- if @langs -%>
langs = ENV.fetch('LANGS').split(",").map(&:to_sym)
activate :i18n, langs: langs, mount_at_root: langs.first
<%- end -%>

activate :asset_hash
activate :directory_indexes
<%- if @token -%>
activate :dato, token: ENV.fetch('DATO_API_TOKEN'), live_reload: true
<%- end -%>

webpack_command =
  if build?
    "yarn run build"
  else
    "yarn run dev"
  end

activate :external_pipeline,
  name: :webpack,
  command: webpack_command,
  source: ".tmp/dist",
  latency: 1

configure :build do
  activate :minify_html do |html|
    html.remove_input_attributes = false
  end
end

configure :development do
  activate :livereload
end

helpers do
  def localized_paths_for(page)
    localized_paths = {}
    sitemap.resources.each do |resource|
      next if !resource.is_a?(Middleman::Sitemap::ProxyResource)
      unless current_page.path == "404.html" || current_page.path == "index.html"
        if resource.target_resource == page.target_resource && resource.metadata[:locals] == page.metadata[:locals]
          localized_paths[resource.metadata[:options][:locale]] = resource.url
        end
      end
    end
    localized_paths
  end

  def favicon_json_path(path, escape = '\/')
    image_path(path).gsub(/\//, escape)
  end

  def image_lazy(image, url_options, sizes = [], attributes = {})
    options = attributes.symbolize_keys
    url_options.merge!({auto: 'format,compress'})

    options[:title] ||= image.title
    options[:alt] ||= image.alt

    sizes_string = sizes.map do |width, size|
      "#{image.url(url_options.merge!({w: width}))} #{size}w"
    end
    options.merge!({
      data: {src: image.url(url_options), srcset: sizes_string.join(", ")}
    })

    image_tag(image.url(url_options.merge!({w: sizes.first.last})), options)
  end

  def image_tag(path, options_hash = {})
    options = options_hash.dup
    if !options.key?(:class)
      options[:class] = "lazyload"
    else
      old_class = options.delete(:class)
      options[:class] = "lazyload #{old_class}"
    end

    super(path, options)
  end
end

<%- if @token -%>
# dato.tap do |dato|
#   dato.landing.each do |article|
#     proxy(
#       '/index.html',
#       '/templates/index.html',
#       locals: { page: dato.landing }
#     )
#   end

#   MULTILANG SAMPLES
#   langs.each do |locale|
#     I18n.with_locale(locale) do
#       proxy "/#{locale}/index.html",
#         "/template/index.html",
#         locals: { page: dato.homepage },
#         locale: locale
#
#     end
#   end
# end
<%- end -%>

proxy "site.webmanifest",
  "templates/site.webmanifest",
  :layout => false

proxy "browserconfig.xml",
  "templates/browserconfig.xml",
  :layout => false

proxy "/_redirects",
  "/templates/redirects.txt",
  :layout => false

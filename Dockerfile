FROM ruby:latest

RUN apt -y update && apt install -y nginx

COPY nginx /etc/nginx/sites-available/default

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

RUN jekyll build
RUN mkdir -p /var/www/html && ln -s /usr/src/app/_site /var/www/html/_site

EXPOSE 80/tcp

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
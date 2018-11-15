FROM elasticsearch:6.4.2

RUN bin/elasticsearch-plugin install analysis-phonetic
RUN bin/elasticsearch-plugin install analysis-icu

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
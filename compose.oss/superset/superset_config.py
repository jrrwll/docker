
"""
docker run -d --name=superset \
  -p 8088:8088 \
  -e "TZ=Asia/Shanghai" \
  -v ./superset/superset_config.py:/app/pythonpath/superset_config.py \
  -v ./superset/superset.db:/app/superset_home/superset.db \
  apache/superset

superset fab create-admin \
    --username admin \
    --firstname Superset \
    --lastname Admin \
    --email admin@superset.com \
    --password admin

superset db upgrade
superset init
"""

SECRET_KEY = 'superset'
# 默认sqlite ~/.superset/superset.db
# postgresql://superset:superset@postgres/superset
SQLALCHEMY_DATABASE_URI = 'mysql://superset:superset@mysql/superset'
WTF_CSRF_ENABLED = False
TALISMAN_ENABLED = False

BABEL_DEFAULT_LOCALE = "zh"
LANGUAGES = {
    "zh": {"flag": "cn", "name": "简体中文"},
    "en": {"flag": "us", "name": "English"},
    "ja": {"flag": "jp", "name": "Japanese"},
    "fr": {"flag": "fr", "name": "French"},
    "es": {"flag": "es", "name": "Spanish"},
    "pt": {"flag": "pt", "name": "Portuguese"},
}

# 开启Jinja模板功能
# https://superset.apache.org/docs/configuration/sql-templating/
ENABLE_TEMPLATE_PROCESSING = True

# 开启告警能力
ALERT_REPORTS = True

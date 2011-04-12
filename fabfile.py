from qi_toolkit.fabbase import *

setup_env_centos("qiserver","root",
                initial_settings={
                    'staging_hosts':[],
                    'production_hosts':['qistaging.com'],
                    'production_db_hosts':['qistaging.com'],
                    'staging_db_hosts':[]
                }, 
                overrides={
                    'git_origin':"http://git@github.com:skoczen/qi-server.git",
                    # 'dry_run':True,
                    'local_working_path':"~/workingCopy/qi/qiserver.git",
                },
                )

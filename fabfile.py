from qi_toolkit.fabbase import *

setup_env_centos("qiserver","root",
                initial_settings={
                    'staging_hosts':[],
                    'production_hosts':['50.17.47.150'],
                    'production_db_hosts':[],
                    'staging_db_hosts':[]
                }, 
                overrides={
                    'git_origin':"http://50.17.47.150/qiserver.git",
                    # 'dry_run':True,
                    'local_working_path':"~/workingCopy/qi/qiserver.git",
                },
                )

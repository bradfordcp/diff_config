# Diff Config

Tool for diffing a large number of configuration files. Currently supports .yaml, .conf, and .properties

## DEV Commands

```
diff_config -s 'configs/address.yaml' -t 'test_configs/DEV/**/address.yaml'
diff_config -s 'configs/cassandra.yaml' -t 'test_configs/DEV/**/cassandra.yaml' -w rpc_address,listen_address
diff_config -s 'configs/cassandra-rackdc.properties' -t 'test_configs/DEV/**/cassandra-rackdc.properties'
diff_config -s 'configs/dse.yaml' -t 'test_configs/DEV/**/dse.yaml'
diff_config -s 'configs/spark-defaults.conf' -t 'test_configs/DEV/**/spark-defaults.conf'
```

*MD5 used for files which cannot be directly compared. Look for differing hashes*

```
md5 configs/cassandra-env.sh
md5 test_configs/DEV/**/cassandra-env.sh

md5 configs/spark-env.sh
md5 test_configs/DEV/**/spark-env.sh
```

## CAT Commands

```
diff_config -s 'configs/address.yaml' -t 'test_configs/CAT/**/address.yaml'
diff_config -s 'configs/cassandra.yaml' -t 'test_configs/CAT/**/cassandra.yaml' -w rpc_address,listen_address
diff_config -s 'configs/cassandra-rackdc.properties' -t 'test_configs/CAT/**/cassandra-rackdc.properties'
diff_config -s 'configs/dse.yaml' -t 'test_configs/CAT/**/dse.yaml'
diff_config -s 'configs/spark-defaults.conf' -t 'test_configs/CAT/**/spark-defaults.conf'
```

*MD5 used for files which cannot be directly compared. Look for differing hashes*

```
md5 configs/cassandra-env.sh
md5 test_configs/CAT/**/cassandra-env.sh

md5 configs/spark-env.sh
md5 test_configs/CAT/**/spark-env.sh
```

## SIT Commands

```
diff_config -s 'configs/address.yaml' -t 'test_configs/SIT/**/address.yaml'
diff_config -s 'configs/cassandra.yaml' -t 'test_configs/SIT/**/cassandra.yaml' -w rpc_address,listen_address
diff_config -s 'configs/cassandra-rackdc.properties' -t 'test_configs/SIT/**/cassandra-rackdc.properties'
diff_config -s 'configs/dse.yaml' -t 'test_configs/SIT/**/dse.yaml'
diff_config -s 'configs/spark-defaults.conf' -t 'test_configs/SIT/**/spark-defaults.conf'
```

*MD5 used for files which cannot be directly compared. Look for differing hashes*

```
md5 configs/cassandra-env.sh
md5 test_configs/SIT/**/cassandra-env.sh

md5 configs/spark-env.sh
md5 test_configs/SIT/**/spark-env.sh
```
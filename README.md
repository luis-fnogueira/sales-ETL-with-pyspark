# Sales ETL with PySpark
### The goal of this project is to practice building a pipeline with PySpark

I've created sample data using SQL. It simulates data extracted from an ERP about sales and load it into a data warehouse. As I'm looking to improve my PySpark code and not model a DW, I'm keeping it simple.

The SQLs codes can be found on the `sql` folder in this repository.

![image](https://i.imgur.com/3YsFo2A.png)



# 1. Reading data

```
import psycopg2
import pandas as pd
from pyspark.sql import SparkSession
from sqlalchemy import create_engine

appName = "salesETL"
master = "local"

spark = SparkSession.builder.master(master).config("spark.driver.extraClassPath", "./postgresql-42.5.1.jar").appName(appName).getOrCreate()

# Reading sales table and address dimension
engine = create_engine(
    "postgresql+psycopg2://admin:admin@postgres_container/postgres?client_encoding=utf8")
pdf_oltp = pd.read_sql('select * from sales.sales', engine)
pdf_dimension = pd.read_sql('select * from sales.address_dimension', engine)


# Convert Pandas dataframe to spark DataFrame
df_oltp = spark.createDataFrame(pdf_oltp)
df_dimension = spark.createDataFrame(pdf_dimension)
```

```
spark.conf.set('spark.sql.analyzer.failAmbiguousSelfJoin', False)
spark.conf.set('spark.sql.caseSensitive', True)

# Checking sales table
df_oltp.show(5)

# Checking dimension table
df_dimension.show(5)

# Getting number of partitions
df_oltp.rdd.getNumPartitions()

# Setting an alias for both tables
df_oltp = df_oltp.alias('a')
df_dimension = df_dimension.alias('b')
```

# 2. Joining tables

```# Creating fact table
df_fact_table = df_oltp.join(df_dimension, df_oltp['customer_city'] == df_dimension['city'],"inner")\
                       .join(df_dimension, df_oltp['customer_state'] == df_dimension['state'], "inner")\
                       .drop(df_dimension['address_id'])\
                       .select("a.order_id",
                               "a.quantity",
                               "a.order_value",
                               "a.order_date",
                               "a.customer_id",
                               "a.product_id",
                               "b.address_id").persist()
```

```
# Creating a view from the df with fact table data
df_fact_table.createOrReplaceTempView("df_fact_table")

 # Querying data to check its content
spark.sql("select * from df_fact_table").show()
```

# 3. Loading fact table

```
# Loading data to fact table

spark.sql("select * from df_fact_table").write.mode("overwrite").format("jdbc")\
             .option("url", "jdbc:postgresql://postgres_container:5432/postgres") \
             .option("driver", "org.postgresql.Driver")\
             .option("dbtable", "fact_table") \
             .option("user", "admin")\
             .option("password", "admin").save()
```
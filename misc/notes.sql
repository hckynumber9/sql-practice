{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "ename": "ModuleNotFoundError",
     "evalue": "No module named 'pyspark'",
     "output_type": "error",
     "traceback": [
      "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[0;31mModuleNotFoundError\u001b[0m                       Traceback (most recent call last)",
      "\u001b[0;32m<ipython-input-1-24cde7a0efcf>\u001b[0m in \u001b[0;36m<module>\u001b[0;34m\u001b[0m\n\u001b[0;32m----> 1\u001b[0;31m \u001b[0;32mimport\u001b[0m \u001b[0mpyspark\u001b[0m \u001b[0;32mas\u001b[0m \u001b[0mps\u001b[0m    \u001b[0;31m# for the pyspark suite\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[0m\u001b[1;32m      2\u001b[0m \u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      3\u001b[0m \u001b[0mspark\u001b[0m \u001b[0;34m=\u001b[0m \u001b[0mps\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0msql\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mSparkSession\u001b[0m\u001b[0;34m.\u001b[0m\u001b[0mbuilder\u001b[0m\u001b[0;31m \u001b[0m\u001b[0;31m\\\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      4\u001b[0m             \u001b[0;34m.\u001b[0m\u001b[0mmaster\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m\"local[2]\"\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;31m \u001b[0m\u001b[0;31m\\\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n\u001b[1;32m      5\u001b[0m             \u001b[0;34m.\u001b[0m\u001b[0mappName\u001b[0m\u001b[0;34m(\u001b[0m\u001b[0;34m\"df lecture\"\u001b[0m\u001b[0;34m)\u001b[0m\u001b[0;31m \u001b[0m\u001b[0;31m\\\u001b[0m\u001b[0;34m\u001b[0m\u001b[0;34m\u001b[0m\u001b[0m\n",
      "\u001b[0;31mModuleNotFoundError\u001b[0m: No module named 'pyspark'"
     ]
    }
   ],
   "source": [
    "import pyspark as ps    # for the pyspark suite\n",
    "\n",
    "spark = ps.sql.SparkSession.builder \\\n",
    "            .master(\"local[2]\") \\\n",
    "            .appName(\"df lecture\") \\\n",
    "            .getOrCreate()\n",
    "\n",
    "sc = spark.sparkContext \n",
    "print(\"woot\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.7.6"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}

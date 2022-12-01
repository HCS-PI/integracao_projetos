import tkinter
import platform
from random import *
import time
import psutil
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from comandoAzure import insert_cpu, insert_disco, insert_proc, insert_ram, inserirConsumoCPUAws, inserirTempCPUAws, inserirConsumoRAMAws, inserirConsumoDISCOAws
import pandas as pd
import datetime as dt
from conexaoBanco import criar_conexao
from wordcloud import WordCloud
from conexaoBanco import criar_conexao_local, criar_conexao_cloud


# crawler
from urllib3 import PoolManager
from json import loads


conexao = criar_conexao_cloud()
cursor = conexao.cursor()
query = 'insert into Medida values (CURRENT_TIMESTAMP,' + '13.3' + ', 3);'
cursor.execute(query)
print(conexao)
conexao.commit()
cursor.close()

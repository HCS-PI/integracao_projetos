import mysql.connector
from lib2to3.pgen2 import driver
import pyodbc

def criar_conexao (host,usuario,senha,nomeBD):
    conexao = mysql.connector.connect(host=host,user=usuario,password=senha,database=nomeBD)
    return conexao

def fechar_conexao(conexao):
    conexao.close()


def criar_conexao_local():
    return mysql.connector.connect(host="localhost", user="root", password="", database="hardware_control_system", autocommit=True)


def criar_conexao_cloud():
    driver = "ODBC Driver 18 for SQL Server"
    server = "tcp:hcs-bd.database.windows.net,1433"
    database = "hcs-bd"
    username = "hcs-Grupo09"
    password = "hardwareCSg9"
    
    string_conexao = 'Driver={'+ driver +'};'+ 'Server=' + server + ';Database=' + database +';Uid='+ username + ';Pwd='+ password + ';Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;'
    conexao = pyodbc.connect(string_conexao)
    return conexao




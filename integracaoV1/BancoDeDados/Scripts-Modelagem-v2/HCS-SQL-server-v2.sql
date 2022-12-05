
CREATE DATABASE hardware_control_system;

USE  hardware_control_system;

CREATE TABLE Empresa(
id_empresa INT PRIMARY KEY IDENTITY(1,1)
,nome_empresa VARCHAR(40)
,cnpj VARCHAR(18)
);

CREATE TABLE Funcionario(
id_funcionario INT PRIMARY KEY IDENTITY(1,1)
,nome_funcionario VARCHAR(64)
,cpf CHAR(14)
,email VARCHAR(100)
,senha VARCHAR(256)
,cargo CHAR(3)
,fk_empresa INT FOREIGN KEY REFERENCES Empresa(id_empresa)
);


CREATE TABLE ServidorAws(
id_servidor INT PRIMARY KEY  IDENTITY(1,1),
,endereco_mac VARCHAR(17)
,modelo VARCHAR(64)
,fk_empresa INT FOREIGN KEY REFERENCES Empresa(id_empresa)
);

CREATE TABLE Carro(
id_carro INT PRIMARY KEY IDENTITY(1,1)
,endereco_mac VARCHAR(17)
,placa_carro CHAR(7)
,modelo VARCHAR(64)
,fk_empresa INT FOREIGN KEY REFERENCES Empresa(id_empresa)
);

CREATE TABLE Dispositivo(
id_dispositivo INT PRIMARY KEY IDENTITY(1,1)
,tipo VARCHAR(45)
,modelo VARCHAR(45)
,unid_medida VARCHAR(10)
,fk_carro INT FOREIGN KEY REFERENCES Carro(id_carro)
,fk_servidor_aws INT FOREIGN KEY REFERENCES ServidorAws(id_servidor)
);

CREATE TABLE Medida(
id_medida INT PRIMARY KEY  IDENTITY(1,1)
,horario_registro DATETIME
,valor DECIMAL(5,1)
,fk_dispositivo INT FOREIGN KEY REFERENCES Dispositivo(id_dispositivo)
);

CREATE TABLE Processo(
id INT PRIMARY KEY IDENTITY(1,1)
,pid INT
,nome varchar(1000)
,fk_carro INT FOREIGN KEY REFERENCES Carro(id_carro)
);

CREATE TABLE MedidaProcesso(
id INT PRIMARY KEY IDENTITY(1,1)
,cpu_perc DECIMAL(5,1)
,horario_registro DATETIME
,fk_processo INT FOREIGN KEY REFERENCES Processo(id)
);

/* Cadastrando a empresa HCS e seus respectivos dados*/
insert into Empresa (nome_empresa, cnpj) 
			values ('Hardware Control System', '36.641.878/0001-53');

insert into Funcionario (nome_funcionario ,cpf ,email ,senha ,cargo,fk_empresa)
			values ('Vinicius Alves', '371.465.370-80','vinicius.alves@hcs.com', '1234', 'TEC', 1);

insert into ServidorAws(endereco_mac ,modelo, fk_empresa) 
			values ('E8-J2-3F-K6-F1-2B', 't2.large', 1);

insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_servidor_aws) 
			values ('CPU', 'Intel Xeon - 2 vCpu ', '%',  1);
            
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_servidor_aws)
			values ('CPU', 'Intel Xeon - 2 vCpu ', '°C', 1);
            
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_servidor_aws)
			values ('RAM', 'Kingston 8GB', '%', 1); 
            
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_servidor_aws)
			values ('DISCO', 'Toshiba 20Gb', '%', 1); 



/*DADOS DA TESLA*/
insert into Empresa (nome_empresa, cnpj) 
			values ('Tesla Corporation', '35.008.715/0001-75');

insert into Funcionario (nome_funcionario ,cpf ,email ,senha ,cargo,fk_empresa) values
						('Carlos Alberto', '996.912.830-26','teslaADM@gmail.com', 'senhasecreta123', 'ADM', 2),
                        ('Rodrigo Almeida', '123.789.652-45','teslaTEC@gmail.com', 'senhasecreta123', 'TEC', 2),
                        ('Matheus Silva', '987-654-321-02','teslaGES@gmail.com', 'senhasecreta123', 'GES', 2);
            

insert into Carro (endereco_mac ,placa_carro ,modelo, fk_empresa)
			values ('C2-F2-9F-2A-F9-7C', 'ABC1256', 'Model S', 2);            
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '%', 1);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '°C', 1);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('RAM', 'Corsair 16GB, 2133Mhz, DDR4', '%', 1);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('DISCO', 'Toshiba 50Gb', '%', 1); 


insert into Carro (endereco_mac ,placa_carro ,modelo, fk_empresa)
			values ('87-93-87-EF-B1-0B', 'CDE1234', 'Model X', 2);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 10500H', '%', 2);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '°C', 2);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('RAM', 'Corsair 16GB, 2133Mhz, DDR4', '%', 2);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('DISCO', 'Toshiba 50Gb', '%', 2); 
            

insert into Carro (endereco_mac ,placa_carro ,modelo, fk_empresa)
			values ('4C-51-A4-69-33-44', 'EFG4567', 'Model G', 2);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 10500H', '%', 3);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '°C', 3);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('RAM', 'Corsair 16GB, 2133Mhz, DDR4', '%', 3);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('DISCO', 'Toshiba 50Gb', '%', 3); 

insert into Carro (endereco_mac ,placa_carro ,modelo, fk_empresa)
			values ('4C-51-A4-69-33-44', 'ZSD7895', 'Model Y', 2);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 10500H', '%', 4);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '°C', 4);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('RAM', 'Corsair 16GB, 2133Mhz, DDR4', '%', 4);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('DISCO', 'Toshiba 50Gb', '%', 4); 



/*DADOS HYUNDAI*/
insert into Empresa (nome_empresa, cnpj) 
			values ('Hyundai', '05.127.365/0001-03');

insert into Funcionario (nome_funcionario ,cpf ,email ,senha ,cargo,fk_empresa)
			values ('Leonardo Vasconcelos', '802.916.120-40','hyundaiADM@gmail.com', 'senhasecreta123', 'ADM', 3),
            ('Clarice Alves', '456.123.789-45','hyundaiGES@gmail.com', 'senhasecreta123', 'GES', 3);

insert into Carro (endereco_mac ,placa_carro ,modelo, fk_empresa)
			values ('10-B1-A8-76-99-DD', 'EFG7891', 'Ioniq 5', 3);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '%', 5); 
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('CPU', 'Intel i5 7400', '°C', 5); 
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('RAM', 'Kingston 8GB', '%', 5);
insert into Dispositivo (tipo ,modelo ,unid_medida ,fk_carro)
			values ('DISCO', 'Toshiba 50Gb', '%', 5); 


/*Inserindo medidas no carro Model S da Tesla*/
INSERT INTO Medida (horario_registro, valor, fk_dispositivo)
			values (CURRENT_TIMESTAMP, 50.0, 5)
				   ,(CURRENT_TIMESTAMP, 50.0, 6)
				   ,(CURRENT_TIMESTAMP, 77.0, 7)
			       ,(CURRENT_TIMESTAMP, 44.0, 8)
				   ,(CURRENT_TIMESTAMP, 82.7, 5)
				   ,(CURRENT_TIMESTAMP, 77.0, 6)
			       ,(CURRENT_TIMESTAMP, 44.0, 7)
                   ,(CURRENT_TIMESTAMP, 50.0, 8);
                   
/*Inserindo medidas no carro Model X da Tesla*/
INSERT INTO Medida (horario_registro, valor, fk_dispositivo)
			values (CURRENT_TIMESTAMP, 50.0, 9)
				   ,(CURRENT_TIMESTAMP, 50.0, 10)
				   ,(CURRENT_TIMESTAMP, 77.0, 11)
			       ,(CURRENT_TIMESTAMP, 44.0, 12)
				   ,(CURRENT_TIMESTAMP, 82.7, 9)
				   ,(CURRENT_TIMESTAMP, 77.0, 10)
			       ,(CURRENT_TIMESTAMP, 44.0, 11)
                   ,(CURRENT_TIMESTAMP, 50.0, 12);
				
/*Inserindo medidas no carro Model G da Tesla*/
INSERT INTO Medida (horario_registro, valor, fk_dispositivo)
			values (CURRENT_TIMESTAMP, 50.0, 13)
				   ,(CURRENT_TIMESTAMP, 50.0, 14)
				   ,(CURRENT_TIMESTAMP, 77.0, 15)
			       ,(CURRENT_TIMESTAMP, 44.0, 16)
				   ,(CURRENT_TIMESTAMP, 24.5, 13)
				   ,(CURRENT_TIMESTAMP, 4.89, 14)
			       ,(CURRENT_TIMESTAMP, 35.6, 15)
                   ,(CURRENT_TIMESTAMP, 75.0, 16);

/*Inserindo medidas no carro Model Y da Tesla*/
INSERT INTO Medida (horario_registro, valor, fk_dispositivo)
			values (CURRENT_TIMESTAMP, 50.0, 17)
				   ,(CURRENT_TIMESTAMP, 89.50, 18)
				   ,(CURRENT_TIMESTAMP, 56.50, 19)
			       ,(CURRENT_TIMESTAMP, 44.0, 20)
				   ,(CURRENT_TIMESTAMP, 24.5, 17)
				   ,(CURRENT_TIMESTAMP, 4.89, 18)
			       ,(CURRENT_TIMESTAMP, 45.6, 19)
                   ,(CURRENT_TIMESTAMP, 75.0, 20);
                   
/*Inserindo medidas no carro Ioniq 5 da Hyundai*/
INSERT INTO Medida (horario_registro, valor, fk_dispositivo)
			values (CURRENT_TIMESTAMP, 50.0, 21)
				   ,(CURRENT_TIMESTAMP, 89.50, 22)
				   ,(CURRENT_TIMESTAMP, 56.50, 23)
			       ,(CURRENT_TIMESTAMP, 44.0, 24)
				   ,(CURRENT_TIMESTAMP, 24.5, 21)
				   ,(CURRENT_TIMESTAMP, 4.89, 22)
			       ,(CURRENT_TIMESTAMP, 45.6, 23)
                   ,(CURRENT_TIMESTAMP, 75.0, 24);

GO
CREATE VIEW vwDashGesCPU AS 
SELECT TOP 5 id_empresa as 'CodEmpresa',
		Carro.modelo AS 'ModeloCarro',
		tipo AS 'Componente',
		unid_medida AS 'UnidadeMedida',
		round(avg(valor),1) AS 'MediaConsumo' FROM Empresa, Carro, Dispositivo, Medida
WHERE id_empresa = fk_empresa AND fk_carro = id_carro 
AND fk_dispositivo = id_dispositivo AND tipo = 'CPU' AND unid_medida = '%'
group by Carro.modelo, id_empresa,tipo,unid_medida;


GO
CREATE VIEW vwDashGesRAM AS 
SELECT TOP 5 id_empresa as 'CodEmpresa',
		Carro.modelo as 'ModeloCarro',
		tipo as 'Componente',
		unid_medida as 'Unidade de Medida',
		round(avg(valor),1) as 'MediaConsumo'
		FROM Empresa, Carro, Dispositivo, Medida
		WHERE fk_empresa = id_empresa AND fk_carro = id_carro AND fk_dispositivo = id_dispositivo AND tipo = 'RAM' AND unid_medida = '%'
		group by Carro.modelo,id_empresa,tipo,unid_medida;

GO
CREATE VIEW vwDashTec AS
Select TOP 100 id_empresa as CodEmpresa,
Carro.id_carro AS 'IdCarro',
Carro.modelo AS 'Modelo',
Carro.placa_carro AS 'Placa',
Medida.valor as 'Valor',
tipo as 'Componente',
unid_medida as 'UnidadeMedida' 
FROM Empresa, Carro, Dispositivo, Medida
WHERE fk_empresa = id_empresa AND fk_carro = id_carro AND fk_dispositivo = id_dispositivo
GROUP BY id_empresa,Medida.valor, id_medida, unid_medida, Carro.id_carro,Carro.modelo,Carro.placa_carro,tipo
ORDER BY id_medida DESC;
 

CREATE VIEW vwServerAWSInfoCPU as
SELECT TOP 10 id_medida,
horario_registro,
unid_medida,
valor as Valores,
fk_dispositivo as Dispositivo
FROM Dispositivo, Medida
WHERE fk_servidor_aws = 1 AND id_dispositivo > 0 AND id_dispositivo < 3 AND id_dispositivo = fk_dispositivo AND tipo = 'CPU'
order by id_medida desc;

/*Inserindo dados de temp nos disp. do servidor AWS*/
INSERT INTO Medida (horario_registro, valor, fk_dispositivo) VALUES
															(CURRENT_TIMESTAMP, 35.58, 2)
															(CURRENT_TIMESTAMP, 25.14, 2)
															(CURRENT_TIMESTAMP, 75.65, 2)
															(CURRENT_TIMESTAMP, 67.32, 2);
GO
CREATE VIEW vwDashAwsConsumoRAM AS
SELECT TOP 5 id_medida,
horario_registro,
unid_medida as 'Unidade de Medida',
valor as ConsumoRam
FROM Dispositivo, Medida
WHERE unid_medida = '%' AND fk_servidor_aws = 1 AND id_dispositivo = 3 AND id_dispositivo = fk_dispositivo
ORDER BY id_medida desc;

GO
CREATE VIEW vwDashAwsConsumoDISCO AS
SELECT TOP 1 id_medida,
horario_registro,
unid_medida as 'Unidade de Medida',
valor as ConsumoDisco
FROM Dispositivo, Medida
WHERE unid_medida = '%' AND fk_servidor_aws = 1 AND id_dispositivo = 4 AND id_dispositivo = fk_dispositivo
ORDER BY id_medida desc;


GO
CREATE VIEW vwDispositivos As 
 Select   tipo, unid_medida, fk_carro,
    id_medida, Medida.horario_registro, Medida.valor AS 'valor'
    from Dispositivo, Carro, Medida 
    where Dispositivo.fk_carro = id_carro and fk_dispositivo = id_dispositivo;


GO
CREATE VIEW vwProcessos As 
select   nome, cpu_perc, horario_registro, fk_carro
    from Processo, MedidaProcesso
    where Processo.id = fk_processo and  nome <> 'System Idle Process';
    

GO
CREATE VIEW vwPegarCpu As 
Select   tipo, unid_medida, fk_carro,
    id_medida, Medida.horario_registro, Medida.valor AS 'valor'
    from Dispositivo, Carro, Medida 
    where Dispositivo.fk_carro = id_carro and fk_dispositivo = id_dispositivo 
	and Dispositivo.tipo = "CPU";
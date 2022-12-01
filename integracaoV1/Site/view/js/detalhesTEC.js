setInterval(() => {
  graficosLine();
  gerarDados();
}, 1000);
setInterval(() => {
  graficoPie();
}, 5000);

function verCarro() {
  var idCarro = sessionStorage.ID_Carro;

  console.log(idCarro);
  fetch("/dashTecnico/verDetalhes", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      idCarro: idCarro,
    }),
  }).then(function (resposta) {
    if (resposta.ok) {
      resposta.json().then((json) => {
        for (var index = 0; index < json.length; index++) {
          mac = json[index].endereco_mac;
          placa = json[index].placa_carro;
          modelo = json[index].modelo;
          placaCarro.innerHTML = `${placa}`;
          modeloCarro.innerHTML = `${modelo}`;
        }
      });
    }
  });
}

function gerarDados() {
  var idCarro = sessionStorage.ID_Carro;
  var vtCPU = [];
  var vtRAM = [];

  fetch("/dashTecnico/dispositivos", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      idCarro: idCarro,
    }),
  }).then(function (resposta) {
    if (resposta.ok) {
      resposta.json().then((json) => {
        json.reverse();
        for (var index = 0; index < json.length; index++) {
          tipoDisp = json[index].tipo;
          horario = json[index].horario_registro;
          valor = json[index].valor;
          tip = json[index].unid_medida;

          if (tipoDisp == "RAM") {
            valRam.innerHTML = `${valor}%`;
            vtRAM.push(valor);

            if (valor > 0 && valor <= 60) {
              ram.style = "background: #00FAAC;";
            } else if (valor > 60 && valor < 80) {
              ram.style = "background: #FFFF7C;";
            } else {
              ram.style = "background: #FF3559;";
            }
          } else if (tipoDisp == "CPU") {
            if (tip == "°C") {
              valTemp.innerHTML = `${valor}°C`;
              if (valor > 0 && valor <= 60) {
                temp.style = "background: #00FAAC;";
              } else if (valor > 60 && valor < 80) {
                temp.style = "background: #FFFF7C;";
              } else {
                temp.style = "background: #FF3559;";
              }
            } else if (tip == "%") {
              valCPU.innerHTML = `${valor}%`;
              vtCPU.push(valor);
              if (valor > 0 && valor <= 60) {
                cpu.style = "background: #00FAAC;";
              } else if (valor > 60 && valor < 80) {
                cpu.style = "background: #FFFF7C;";
              } else {
                cpu.style = "background: #FF3559;";
              }
            }
          }
        }
      });
    }
  });
}

function graficoDispRam() {
  var idCarro = sessionStorage.ID_Carro;
  var vtData = [];
  var vtHorario = [];
  var vtDataSemFormatacao = [];
  valoresRam = [];

  fetch("/dashTecnico/dadosRam", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      idCarro: idCarro,
    }),
  }).then(function (resposta) {
    if (resposta.ok) {
      resposta.json().then((json) => {
        json = json.reverse();
        i = 0;
        for (var index = 0; index < json.length; index++) {
          tipoDisp = json[index].tipo;
          vtDataSemFormatacao.push(json[index].horario_registro);
          valor = json[index].valor;

          var limparData = vtDataSemFormatacao[i].split(".");
          var separarHorario = limparData[0].split("T");
          vtData.push(separarHorario[0]);
          vtHorario.push(separarHorario[1]);
          valoresRam.push(valor);
        }
        document.getElementById("grafico1").remove();
        var divGrafico = document.getElementById("graficoBarraRAM");
        var canvas = document.createElement("canvas");
        canvas.id = "grafico1";
        canvas.className = "graficoRAM";
        divGrafico.appendChild(canvas);

        let labels = [];

        var dados = {
          labels: labels,
          datasets: [
            {
              label: "Ram(%)",
              lineTension: 0.3,
              backgroundColor: "#1345EB37",
              borderColor: "#002AFF",
              pointRadius: 6,
              pointHoverRadius: 10,
              stepped: true,
              data: [
                valoresRam[0],
                valoresRam[1],
                valoresRam[2],
                valoresRam[3],
                valoresRam[4],
              ],
              fill: true,
            },
          ],
          options: {
            maintainAspectRatio: false,
            responsive: true,
          },
        };

        for (i = 0; i < json.length; i++) {
          var registro = json[i];
          var dataHorario = registro.horario_registro.split("T");
          dataHorario = [
            dataHorario[0].replace(/-/g, "/"),
            dataHorario[1].slice(0, 8),
          ];
          labels.push(dataHorario[1]);
        }

        const config = {
          type: "line",
          data: dados,
          options: {
            maintainAspectRatio: false,
            responsive: true,
            animation: 1,
            scales: {
              y: {
                suggestedMin: 0,
                suggestedMax: 100,
                grid: {
                  color: function (context) {
                    if (context.tick.value >= 80) {
                      return "#F40707";
                    } else if (context.tick.value >= 50) {
                      return "#E8F407";
                    } else if (context.tick.value < 50) {
                      return "#46F407";
                    }

                    return "#000000";
                  },
                },
              },
            },
          },
        };

        let myChartCpu = new Chart(document.getElementById("grafico1"), config);
      });
    }
  });
}

function graficoDispCpu() {
  var idCarro = sessionStorage.ID_Carro;
  var vtData = [];
  var vtHorario = [];
  var vtDataSemFormatacao = [];
  valoresUsoCPU = [];
  tempCPU = [];

  fetch("/dashTecnico/dadosCpu", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      idCarro: idCarro,
    }),
  }).then(function (resposta) {
    if (resposta.ok) {
      resposta.json().then((json) => {
        json = json.reverse();
        i = 0;

        document.getElementById("grafico2").remove();
        var divGrafico = document.getElementById("graficoBarraCpu");
        var canvas = document.createElement("canvas");
        canvas.id = "grafico2";
        canvas.className = "graficoCPU";
        divGrafico.appendChild(canvas);

        let labels = [];

        for (var index = 0; index < json.length; index++) {
          tipoDisp = json[index].tipo;
          vtDataSemFormatacao.push(json[index].horario_registro);
          valor = json[index].valor;
          unidade = json[index].unid_medida;

          if (unidade == "%") {
            valoresUsoCPU.push(valor);

            var registro = json[index];
            var dataHorario = registro.horario_registro.split("T");
            dataHorario = [
              dataHorario[0].replace(/-/g, "/"),
              dataHorario[1].slice(0, 8),
            ];
            labels.push(dataHorario[1]);
          } else if (unidade == "°C") {
            tempCPU.push(valor);
          }
        }

        var dados = {
          labels: labels,
          datasets: [
            {
              type: "line",
              label: "Uso Cpu(%)",
              lineTension: 0.3,
              backgroundColor: "rgba(92, 925, 183, 1.5)",
              borderColor: "rgba(92, 925, 183, 1.5)",
              pointStyle: "rectRounded",
              pointRadius: 8,
              pointHoverRadius: 10,
              data: [
                valoresUsoCPU[0],
                valoresUsoCPU[1],
                valoresUsoCPU[2],
                valoresUsoCPU[3],
                valoresUsoCPU[4],
              ],
            },
            {
              type: "bar",
              label: "Temperatura(°C)",
              backgroundColor: "rgba(250, 5, 35, 0.94)",
              borderColor: "rgba(250, 5, 35, 0.94)",
              borderWidth: 1,
              borderRadius: 10,
              borderSkipped: false,
              data: [
                tempCPU[0],
                tempCPU[1],
                tempCPU[2],
                tempCPU[3],
                tempCPU[4],
              ],
            },
          ],
          options: {
            maintainAspectRatio: false,
            responsive: true,
          },
        };

        const config = {
          data: dados,
          options: {
            maintainAspectRatio: false,
            responsive: false,
            animation: 1,
            scales: {
              y: {
                suggestedMin: 0,
                suggestedMax: 100,
                stacked: true,
              },
            },
          },
        };

        let myChartCpu = new Chart(document.getElementById("grafico2"), config);
      });
    }
  });
}

function verProcesso() {
  var idCarro = sessionStorage.ID_Carro;
  var vtData = [];
  var vtHorario = [];
  var vtDataSemFormatacao = [];
  var vtNomeProcessos = [];
  var vtPidProcessos = [];
  var vtConsumoProcessos = [];

  fetch("/dashTecnico/processos", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      idCarro: idCarro,
    }),
  }).then(function (resposta) {
    if (resposta.ok) {
      resposta.json().then((json) => {
        var i = 0;

        document.getElementById("grafico3").remove();
        var divGrafico = document.getElementById("graficoPieProcessos");
        var canvas = document.createElement("canvas");
        canvas.id = "grafico3";
        canvas.className = "graficoPizza";
        divGrafico.appendChild(canvas);

        contador = 0;

        for (var index = 0; index < json.length; index++) {
          nomeProc = json[index].nome;
          consumo = json[index].cpu_perc;
          vtPidProcessos.push(json[index].pid);
          vtDataSemFormatacao.push(json[index].horario_registro);

          //Separando e formatando data e hora
          var limparData = vtDataSemFormatacao[i].split(".");
          var separarHorario = limparData[0].split("T");

          vtData.push(separarHorario[0]);
          vtHorario.push(separarHorario[1]);

          vtData[i] = vtData[i].split("-").reverse().join("/");

          i++;

          if (!vtNomeProcessos.includes(nomeProc)) {
            vtNomeProcessos.push(nomeProc);
            vtConsumoProcessos.push(parseFloat(consumo));
          } else {
            for (contador = 0; contador < vtNomeProcessos.length; contador++) {
              if (vtNomeProcessos[contador] == nomeProc) {
                vtConsumoProcessos[contador] += parseFloat(consumo);
              }
            }
          }
        }

        const data = {
          labels: [
            vtNomeProcessos[0],
            vtNomeProcessos[1],
            vtNomeProcessos[2],
            vtNomeProcessos[3],
            vtNomeProcessos[4],
          ],
          datasets: [
            {
              label: "Uso CPU(%)",
              backgroundColor: [
                "#00CBFF",
                "#FF8A57",
                "#FB5AE8",
                "#4EFDCC",
                "#FFFEA6",
              ],
              borderColor: "none",
              data: [
                vtConsumoProcessos[0],
                vtConsumoProcessos[1],
                vtConsumoProcessos[2],
                vtConsumoProcessos[3],
                vtConsumoProcessos[4],
              ],
            },
          ],
        };

        const config = {
          type: "doughnut",
          data: data,
          options: {
            responsive: false,
            animation: 0,
            plugins: {
              legend: {
                position: "right",
              },
              title: {
                display: true,
                text: "Processos",
                font: {
                  size: 20,
                },
              },
            },
          },
        };

        let myChartCpu = new Chart(document.getElementById("grafico3"), config);
      });
    }
  });
}

function verDisco() {
  var idCarro = sessionStorage.ID_Carro;
  var vtData = [];
  var vtHorario = [];
  var vtDataSemFormatacao = [];
  var vtNomeProcessos = [];
  var vtPidProcessos = [];
  var vtConsumoProcessos = [];
  var contagens = [];

  fetch("/dashTecnico/processos", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      idCarro: idCarro,
    }),
  }).then(function (resposta) {
    if (resposta.ok) {
      resposta.json().then((json) => {
        var i = 0;

        document.getElementById("grafico4").remove();
        var divGrafico = document.getElementById("graficoPieCpu");
        var canvas = document.createElement("canvas");
        canvas.id = "grafico4";
        canvas.className = "graficoPizzaCPU";
        divGrafico.appendChild(canvas);

        for (var index = 0; index < json.length; index++) {
          nomeProc = json[index].nome;
          consumo = json[index].cpu_perc;
          vtPidProcessos.push(json[index].pid);
          vtDataSemFormatacao.push(json[index].horario_registro);

          //Separando e formatando data e hora
          var limparData = vtDataSemFormatacao[i].split(".");
          var separarHorario = limparData[0].split("T");

          vtData.push(separarHorario[0]);
          vtHorario.push(separarHorario[1]);

          vtData[i] = vtData[i].split("-").reverse().join("/");

          i++;

          if (!vtNomeProcessos.includes(nomeProc)) {
            vtNomeProcessos.push(nomeProc);
            vtConsumoProcessos.push(parseFloat(consumo));
            contagens.push(1);
          } else {
            for (contador = 0; contador < vtNomeProcessos.length; contador++) {
              if (vtNomeProcessos[contador] == nomeProc) {
                vtConsumoProcessos[contador] += parseFloat(consumo);
                contagens[contador] += 1;
              }
            }
          }
        }

        const data1 = {
          labels: [
            vtNomeProcessos
          ],
          datasets: [
            {
              label: "Uso CPU(%)",
              backgroundColor: [
                "#00CBFF",
                "#FF8A57",
                "#FB5AE8",
                "#4EFDCC",
                "#FFFEA6",
              ],
              borderColor: "none",
              data: [
                vtConsumoProcessos
              ],
            },
          ],
        };

        const data = {
          labels: vtConsumoProcessos,
          datasets: [
            {
              label: "Processos",
              data: contagens,
              borderColor: "#FFFEA6",
              backgroundColor: "#FB5AE8",
              radius: 8,
             
            },
          ],
        };

        const config = {
          type: "bubble",
          data: data,
          animation: 0,
          options: {
            responsive: true,
            plugins: {
              legend: {
                position: "top",
              },
              title: {
                display: true,
                text: "Chart.js Bubble Chart",
              },
            },
          },
        };

        let myChartCpu = new Chart(document.getElementById("grafico4"), config);
      });
    }
  });
}

function graficosLine() {
  graficoDispRam();
  graficoDispCpu();
}
function graficoPie() {
  verProcesso();
  verDisco();
}

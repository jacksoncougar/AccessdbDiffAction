using CommandLine;
using System;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Text;

namespace SolutionCliTools
{
	class Program
	{
		public class Options
		{
			[Value(0, MetaName = "Input", Required = true)]
			public string Input { get; set; }
		}

		static void Main(string[] args)
		{
			Parser.Default.ParseArguments<Options>(args)
				.WithParsed(GenerateSchema);
		}

		private static void GenerateSchema(Options obj)
		{
			_ = obj.Input ?? throw new ArgumentNullException(nameof(Options.Input));

			var file = new FileInfo(obj.Input);

			AccessDbFunctions.ConvertAccessFileToXml(file.FullName);
		}
	}

	public static class AccessDbFunctions
	{
		public static void ConvertAccessFileToXml(string accessFilePath)
		{
			if (!File.Exists(accessFilePath))
			{
				throw new ArgumentNullException(nameof(accessFilePath));
			}


			DataSet resultDataSet = new DataSet
			{
				DataSetName = Path.GetFileNameWithoutExtension(accessFilePath)
			};

			OleDbConnection accessConnection = GetConnection(accessFilePath);

			try
			{
				accessConnection.Open();
				DataTable table = accessConnection.GetSchema("Tables");

				foreach (DataRow row in table.Rows)
				{
					if (row.IsTable() is false)
					{
						continue;
					}
					if (row.IsComment())
					{
						continue;
					}

					StringBuilder sortOrder = new StringBuilder();
					OleDbCommand getTableListCommand = new OleDbCommand(string.Format("SELECT * FROM [{0}]", row["TABLE_NAME"]), accessConnection);
					OleDbDataAdapter accessDataAdapter = new OleDbDataAdapter(getTableListCommand);

					DataTable testDataTable = new DataTable();
					accessDataAdapter.Fill(testDataTable);
					int sortCount = 0;

					for (int columnIndex = 0; columnIndex < testDataTable.Columns.Count; columnIndex++)
					{
						if (testDataTable.Columns[columnIndex].DataType != typeof(byte[]))
						{
							sortOrder.Append(string.Format("{0},", columnIndex + 1));
							sortCount++;
						}

						if (sortCount > 20)
						{
							break;
						}
					}
					testDataTable.Dispose();

					getTableListCommand = new OleDbCommand(string.Format("SELECT * FROM [{0}] ORDER BY {1}", row["TABLE_NAME"], sortOrder.ToString().TrimEnd(',')), accessConnection);
					accessDataAdapter = new OleDbDataAdapter(getTableListCommand);

					accessDataAdapter.Fill(resultDataSet, row["TABLE_NAME"].ToString());
				}
				resultDataSet.WriteXml(Console.OpenStandardOutput(40000), XmlWriteMode.WriteSchema);
			}
			finally
			{
				accessConnection.Close();
			}

		}

		private static bool IsComment(this DataRow row)
		{
			return row["TABLE_NAME"].ToString().Trim() == "Comments";
		}

		private static bool IsTable(this DataRow row)
		{
			return row["TABLE_TYPE"].ToString().Trim().ToUpper() == "TABLE";
		}

		private static OleDbConnection GetConnection(string accessFilePath)
		{
			OleDbConnection accessConnection;

			if (accessFilePath.Trim().ToLower().EndsWith(".mdb"))
			{
				accessConnection = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + accessFilePath + ";User Id=Admin;Password=");
			}
			else
			{
				accessConnection = new OleDbConnection(@"Provider=SQLOLEDB;ODBC;DRIVER=ODBC Driver 17 for SQL Server;Data Source=" + accessFilePath + ";User Id=Admin;Password=");
			}

			return accessConnection;
		}

		private static string ConvertStringToDataTable(string xmlString)
		{
			// Search for datetime values of the format
			// --> 2004-08-22T00:00:00.0000000-05:00
			//string rp = @"(?<DATE>\d{4}-\d{2}-\d{2})(?<TIME>T\d{2}:\d{2}:\d{2}." +
			//	  @"\d{7}-)(?<HOUR>\d{2})(?<LAST>:\d{2})";
			const string rp = @"(?<DATE>\d{4}-\d{2}-\d{2})(?<TIME>T\d{2}:\d{2}:\d{2}-)(?<HOUR>\d{2})(?<LAST>:\d{2})";
			// <EffectiveDate>2006-01-01T00:00:00-07:00</EffectiveDate>
			// Replace UTC offset value
			return System.Text.RegularExpressions.Regex.Replace(xmlString, rp,
				 new System.Text.RegularExpressions.MatchEvaluator(getHourOffset));
		}
		private static string getHourOffset(System.Text.RegularExpressions.Match m)
		{
			// Need to also account for Daylights Savings
			// Time when calculating UTC offset value
			string result = m.ToString().Remove(m.ToString().Length - 6);
			return result;
		}
	}
}

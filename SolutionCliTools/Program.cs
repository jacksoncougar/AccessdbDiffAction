using System;
using System.IO;

namespace SolutionCliTools
{
	class Program
	{
		static void Main(string[] args)
		{
			Console.Write(File.ReadAllText(args[0]));
		}
	}
}

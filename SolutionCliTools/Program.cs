using System;
using System.IO;

namespace SolutionCliTools
{
	class Program
	{
		static void Main(string[] args)
		{
			Console.Write(Path.ChangeExtension(args[0], ".xml"), File.ReadAllText(args[0]));
		}
	}
}

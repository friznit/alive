using RGiesecke.DllExport;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.IO;
using System.Net;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Imaging;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace ALiVEClient
{
    public class DllEntry
    {
        public static string UploadStatus = "";
        public static Boolean UploadCompleted = false;
        public static Boolean UploadFailed = false;

        [DllExport("_RVExtension@12", CallingConvention = System.Runtime.InteropServices.CallingConvention.Winapi)]
        public static void RVExtension(StringBuilder output, int outputSize, string args)
        {
            outputSize--;
            string result;
            
            // Get Function and Params
            IList<object> arguments;
            arguments = args.Split(new char[] { '~' });

            // Get Function and Params
            string callfunction = arguments[0].ToString();
            IList<object> callParams;

            callParams = arguments[1].ToString().Split(new char[] { '|' });

            switch (callfunction)
            {   
                // Upload an image to War Room
                case "SendIntelImage":
                {
                    string imageFile = callParams[0].ToString();
                    string group = callParams[1].ToString();
                    string mission = callParams[2].ToString();
                    string user = callParams[3].ToString();
                    string pwd = callParams[4].ToString();

                    WebClient client = new WebClient();
                    client.UploadProgressChanged += new UploadProgressChangedEventHandler(UploadProgressCallback);
                    client.UploadFileCompleted += new UploadFileCompletedEventHandler(UploadCompletedCallback);

                    Uri address = new Uri("http://alivemod.com/api/intelUpload?group=" + group + "&mission=" + mission);

                    // Set image path
                    string imagePath = Path.Combine(System.IO.Directory.GetCurrentDirectory(), "ALiVEIntel/" + imageFile);

                    // Needs to be Async...
                    // Send image via HTTP to ALiVE War Room
                    // Set up HTTP client session

                    string credentials = Convert.ToBase64String(Encoding.ASCII.GetBytes(user + ":" + pwd));
                    client.Headers[HttpRequestHeader.Authorization] = "Basic " + credentials;

                    // Try POST'ing image
                    client.UploadFileAsync(address, imagePath);

                    // Record result
                    result = "SENT";
                    break;
                }
                case "CreateIntelDir":
                    result = "UNKNOWN";
                    if (!System.IO.Directory.Exists(Path.Combine(System.IO.Directory.GetCurrentDirectory(), "ALiVEIntel")))
                    {
                        //Create folder
                        System.IO.Directory.CreateDirectory(Path.Combine(System.IO.Directory.GetCurrentDirectory(), "ALiVEIntel"));
                        result = "CREATED";
                    }
                    else
                    {
                        result = "EXISTS";
                    }
                    break;
                case "SendMap":
                {
                    result = "UNKNOWN";
                    string imageFile = callParams[0].ToString(); // C:\test.emf
                    string fileName = imageFile.Split(new char[] { '.' })[0] + ".png"; // C:\test.png
                    string user = callParams[1].ToString();
                    string pwd = callParams[2].ToString();

                    fileName = fileName.Split(new char[] { '\\' })[1]; // test.png
                    
                    WebClient client = new WebClient();
                    client.UploadProgressChanged += new UploadProgressChangedEventHandler(UploadProgressCallback);
                    client.UploadFileCompleted += new UploadFileCompletedEventHandler(UploadCompletedCallback);

                    // Check if file exists
                    if (File.Exists(imageFile)) {
                        if (!File.Exists(fileName))
                        {
                            // Convert Image from EMF to PNG
                            try
                            {
                                  Bitmap image = new Bitmap(imageFile);
                                  image.Save(Path.Combine(System.IO.Directory.GetCurrentDirectory(), fileName), ImageFormat.Png);
                            }
                            catch (Exception ex)
                            {
                                result = "IMAGE TOO BIG";
                                break;
                            }
                        }
                    } else {
                        result = "FILE DOES NOT EXIST";
                        break;
                    }

                    Uri address = new Uri("ftp://db.alivemod.com/" + fileName);

                    // Set image path
                    string imagePath = Path.Combine(System.IO.Directory.GetCurrentDirectory(), fileName);

                    // Needs to be Async...
                    // Send image via FTP to ALiVE War Room
                    // Set up FTP client session

                    client.Credentials = new NetworkCredential(user, pwd);

                    result = address.ToString() + " " + fileName + " " + imageFile + " " + imagePath;

                    try
                    {
                        // Try uploading map
                        client.UploadFileAsync(address, imagePath);
                    }
                    catch (Exception ex)
                    {
                        result = ex.Message.ToString();
                    }

                    // Record result
                    break;
                }
                case "getUploadProgress":
                {
                    result = "UNKNOWN";
                    if (!ALiVEClient.DllEntry.UploadCompleted && !ALiVEClient.DllEntry.UploadFailed)
                    {
                        result = ALiVEClient.DllEntry.UploadStatus;
                    };
                    if (ALiVEClient.DllEntry.UploadCompleted)
                    {
                        result = "FINISHED";
                        ALiVEClient.DllEntry.UploadCompleted = false;
                    }
                    if (ALiVEClient.DllEntry.UploadFailed)
                    {
                        result = ALiVEClient.DllEntry.UploadStatus;
                        ALiVEClient.DllEntry.UploadCompleted = true;
                        ALiVEClient.DllEntry.UploadFailed = false;
                    }
                    break;
                }
                case "StartIndex":
                {
                    // Creates the objects file for the map

                    // Init result
                    result = "UNKNOWN";

                    // Path to map pbo
                    string pathToMap =  Path.Combine(System.IO.Directory.GetCurrentDirectory(), callParams[0].ToString()); // "Addons\map_altis.pbo"

                    // Path to indexing
                    string folder = Path.Combine(System.IO.Directory.GetCurrentDirectory(), "@ALiVE");
                    if (!Directory.Exists(folder))
                    {
                        result = "ERROR";
                        break;
                    }

                    // Map Name
                    string mapName = callParams[1].ToString(); // "altis"

                    // Log file
                    string logfile = Path.Combine(folder, mapName + "\\log.txt");

                    // Path to dev folder
                    string pathToObjects = Path.Combine(folder, mapName + "\\fnc_strategic\\indexes");

                    // Index Files
                    string indexFile = String.Format("{0}\\objects.{1}.sqf", pathToObjects, mapName);
                    string parsedIndexFile = String.Format("{0}\\parsed.objects.{1}.sqf", pathToObjects, mapName);

                    // Blacklist
                    string blacklistfile = Path.Combine(System.IO.Directory.GetCurrentDirectory(), "@ALIVE\\alive_object_blacklist.txt");
                    string[] blacklist = LoadBlackList(blacklistfile);

                    // Create folder structure for map indexing
                    if (!Directory.Exists(pathToObjects))
                    {
                        Directory.CreateDirectory(pathToObjects);
                    }

                    //Logging
                    System.IO.StreamWriter lfile = new System.IO.StreamWriter(logfile, true);
                    lfile.AutoFlush = true;
                    lfile.WriteLine(">>>>>>>>>>>>>>>>>> Starting Map Index for " + mapName + " on " + DateTime.Now.ToString());

                    if (blacklist == null)
                    {
                        lfile.WriteLine("Couldn't find blacklist, exiting");
                        break;
                    }

                    // Create Index of map
                    ProcessStartInfo startInfo = new ProcessStartInfo();
                    startInfo.CreateNoWindow = false;
                    startInfo.UseShellExecute = false;
                    startInfo.FileName = "cmd.exe";
                    startInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    startInfo.Arguments = "/c DeWrp.exe -O \"" + pathToMap + "\"" + " > \"" + indexFile + "\"";
                    startInfo.RedirectStandardOutput = false;
                    lfile.WriteLine("Executing deWrp: " + startInfo.FileName + " " + startInfo.Arguments);
                    try
                    {
                        Process exeProcess = Process.Start(startInfo);
                        exeProcess.WaitForExit();
                        exeProcess.Close();
                        lfile.WriteLine("deWrp analysis completed");
                    }
                    catch
                    {
                        lfile.WriteLine("deWrp Error");
                        result = "ERROR with deWrp";
                        lfile.Close();
                        break;
                    }

                    // Process indexFile
                    CreateParsedFile(parsedIndexFile);
                    try
                    {
                        //Read in all lines from Index
                        var lines = File.ReadLines(indexFile);
                        bool ignore = false;
                        foreach (var line in lines)
                        {
                            if (line == null)
                            {
                                break;
                            }

                            if (line.Contains("\""))
                            {
                                lfile.WriteLine(String.Format(" -- Parsing {0}", line));

                                //If line contains any value form black list ignore block, else write the block
                                if (blacklist.Any(line.Contains))
                                {
                                    lfile.WriteLine(String.Format(" ----- Ignoring : {0}", line));
                                    ignore = true;
                                }
                                else
                                {
                                    // lfile.WriteLine(String.Format(" ----- Writing : {0}", line));
                                    ignore = false;
                                }
                            }
                            if (line.Contains("];"))
                            {
                                ignore = false;
                            }
                            if (!ignore)
                            {
                                // lfile.WriteLine(String.Format(" ----- Committing to parsedIndexFile : {0}", line));
                                File.AppendAllText(parsedIndexFile, line.ToString() + Environment.NewLine);
                            }
                        }
                    }
                    catch (UnauthorizedAccessException UAEx)
                    {
                        lfile.WriteLine(UAEx.Message);

                    }
                    catch (PathTooLongException PathEx)
                    {

                        lfile.WriteLine(PathEx.Message);

                    }

                    // Check for any messed up array at end
                    List <string> text = File.ReadLines(parsedIndexFile).Reverse().Take(3).ToList();
                    //lfile.WriteLine(text.ElementAt(2).ToString());
                    if (text.ElementAt(2).Contains("],"))
                    {
                        string[] lines = File.ReadAllLines(parsedIndexFile);
                        //lfile.WriteLine(lines[lines.Length - 3].ToString());
                        if (lines[lines.Length - 3].Contains("],"))
                        {
                            lines[lines.Length - 3] = "        ]";
                        }
                        lfile.WriteLine("Corrected objects file as there was an unecessary comma");
                        File.WriteAllLines(indexFile, lines);  
                    }
                    else
                    {
                        File.Copy(parsedIndexFile, indexFile, true);
                    }

                    File.Delete(parsedIndexFile);

                    lfile.WriteLine("Parsing Complete");
                    result = "SUCCESS";
                    lfile.Close();
                    break;
                }
                case "checkStatic":
                {
                    result = "FALSE";
                    // Map Name
                    string mapName = callParams[0].ToString(); // "altis"

                    // Path to indexing
                    string file = Path.Combine(System.IO.Directory.GetCurrentDirectory(), "@ALiVE\\" + mapName + "\\main\\static\\" + mapName + "_staticData.sqf");
                    if (!File.Exists(file))
                    {
                        result = "SUCCESS";
                        break;
                    }
                    else
                    {
                        break;
                    }
                }
                case "startClusters":
                {
                    result = "ERROR";
                    // Creates the Static data entry for the map

                    // Map Name
                    string mapName = callParams[0].ToString(); // "altis"

                    // Directories
                    string mil_cluster_path = "@ALiVE\\" + mapName + "\\mil_placement\\clusters\\";
                    Directory.CreateDirectory(mil_cluster_path);

                    string civ_cluster_path = "@ALiVE\\" + mapName + "\\civ_placement\\clusters\\";
                    Directory.CreateDirectory(civ_cluster_path);

                    string analysis_path = "@ALiVE\\" + mapName + "\\fnc_analysis\\data\\";
                    Directory.CreateDirectory(analysis_path);                  
                    
                    // Logging
                    File.AppendAllText("@ALiVE\\" + mapName + "\\log.txt", "Starting Cluster Generation, check in game RPT for more details." + Environment.NewLine);
                    break;
                }
                case "indexData":
                {
                    result = "ERROR";
                    // Map Name
                    string mapName = callParams[0].ToString(); // "altis"
                    string idata = callParams[1].ToString();
                    string analysis_path = "@ALiVE\\" + mapName + "\\fnc_analysis\\data\\";
                    string analysis_file = analysis_path + "data." + mapName + ".sqf";

                    File.AppendAllText(analysis_file, idata + Environment.NewLine);
                    result = "SUCCESS";
                    break;
                }

                case "clusterData":
                {
                    result = "ERROR";

                    // Map Name
                    string mapName = callParams[0].ToString(); // "altis"
                    string type = callParams[1].ToString();
                    string idata = callParams[2].ToString();

                    string cfile = "";
                    if (type == "mil")
                    {
                        string cpath = "@ALiVE\\" + mapName + "\\mil_placement\\clusters\\";
                        cfile = cpath + "clusters." + mapName + "_mil.sqf";
                    }
                    else
                    {
                        string cpath = "@ALiVE\\" + mapName + "\\civ_placement\\clusters\\";
                        cfile = cpath + "clusters." + mapName + "_civ.sqf";
                    }

                    if (idata.Contains("e-00"))
                    {
                        File.AppendAllText("@ALiVE\\" + mapName + "\\log.txt", "Cluster small number erased: " + idata + Environment.NewLine);
                        idata = Regex.Replace(idata, @"e-00\d", "");
                    }
                    if (!idata.Contains("null"))
                    {
                        File.AppendAllText(cfile, idata + Environment.NewLine);
                    }
                    else
                    {
                        File.AppendAllText("@ALiVE\\" + mapName + "\\log.txt", "Cluster null: " + idata + Environment.NewLine);
                    }
                    result = "SUCCESS";
                    break;
                }
                default:
                    result = "UNKNOWN FUNCTION";
                    break;
            }
            
            output.Append(result);
        }
        private static void UploadProgressCallback(object sender, UploadProgressChangedEventArgs e)
        {
            string output = String.Format("{0} uploaded {1} of {2} bytes. {3} % complete...", 
                (string)e.UserState, 
                e.BytesSent, 
                e.TotalBytesToSend,
                e.ProgressPercentage);
            ALiVEClient.DllEntry.UploadStatus = output;
        }
        private static void UploadCompletedCallback(object sender, UploadFileCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                ALiVEClient.DllEntry.UploadStatus = e.Error.Message.ToString();
                ALiVEClient.DllEntry.UploadFailed = true;
                ALiVEClient.DllEntry.UploadCompleted = false;
            }
            else
            {
                ALiVEClient.DllEntry.UploadCompleted = true;
            }
        }
        public static void CreateParsedFile(string fileName)
        {

            if (File.Exists(fileName))
            {

                Console.WriteLine("Previous Parsed Index file exists, deleting old file");
                File.Delete(fileName);

            }

            File.Create(fileName).Dispose();

        }
        public static string[] LoadBlackList(string fileName)
        {
            if (File.Exists(fileName))
            {
                return File.ReadAllLines(fileName);
            }
            else
            {
                return null;
            }
        }
    }

}

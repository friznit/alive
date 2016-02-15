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

            callParams = arguments[1].ToString().Split(new char[] { ',' });

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

    }

}

import { google } from 'googleapis'

// Path to your JSON key file 
const KEYFILEPATH = './credentials.json';

// Specify the scopes needed
const SCOPES = ['https://www.googleapis.com/auth/spreadsheets'];

// Initialize the auth client
const auth = new google.auth.GoogleAuth({
  keyFile: KEYFILEPATH,
  scopes: SCOPES
});

// Function to authenticate and access the Sheets API
async function accessSpreadsheet () {
  const sheets = google.sheets({ version: 'v4', auth });
  const spreadsheetId = '1f_TkKzFUN_oABqHxL4mjrmeLlESU9pEeoOphhP8X2Oo';

  // Example: Read from the spreadsheet
  const range = 'Company Emissions Database!A:AZ';
  try {
    const response = await sheets.spreadsheets.values.get({
      auth,
      spreadsheetId,
      range,
    })

    return { data: response }
    console.log(response.data);
  } catch (error) {
    console.error('The API returned an error: ' + error);
    return { error }
  }
}


export async function loader () {
  // Call the function
  return accessSpreadsheet();
}
